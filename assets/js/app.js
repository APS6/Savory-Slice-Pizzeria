import "phoenix_html";
// Establish Phoenix Socket and LiveView configuration.
import { Socket } from "phoenix";
import { LiveSocket } from "phoenix_live_view";
import topbar from "../vendor/topbar";
import { createLiveToastHook } from "live_toast";

let csrfToken = document
  .querySelector("meta[name='csrf-token']")
  .getAttribute("content");

let Hooks = {};

Hooks.toggleQuantity = {
  mounted() {
    const decBtn = this.el.querySelector('[data-id="decBtn"]');
    const incBtn = this.el.querySelector('[data-id="incBtn"]');
    const qtyInput = this.el.querySelector('[data-id="qtyInput"]');
    const qtyDiv = this.el.querySelector('[data-id="qtyDiv"]');

    decBtn.addEventListener("click", () => {
      let qty = parseInt(qtyInput.value);
      if (qty > 1) {
        qtyInput.value = qty - 1;
        qtyDiv.innerText = qty - 1;
      }
    });

    incBtn.addEventListener("click", () => {
      let qty = parseInt(qtyInput.value);
      if (qty < 10) {
        qtyInput.value = qty + 1;
        qtyDiv.innerText = qty + 1;
      }
    });
  },
};

Hooks.saveCartToSession = {
  mounted() {
    const csrfToken = document
      .querySelector("meta[name='csrf-token']")
      .getAttribute("content");

    this.el.addEventListener("submit", (e) => {
      let formData = new FormData(e.target);
      let data = Object.fromEntries(formData);
      data.pizza_id = data.id;
      delete data.id;
      data.quantity = parseInt(data.quantity, 10);
      fetch(`/add_to_basket`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": csrfToken,
        },
        body: JSON.stringify(data),
      })
        .then((response) => {
          if (!response.ok) {
            throw new Error("Network response was not ok");
          }
          return response.json();
        })
        .catch((error) => {
          console.error("Error:", error);
        });
    });
  },
};

Hooks.LiveToast = createLiveToastHook(3000);

let liveSocket = new LiveSocket("/live", Socket, {
  longPollFallbackMs: 2500,
  params: { _csrf_token: csrfToken },
  hooks: Hooks,
});

window.addEventListener("phx:setSessionBasket", ({ detail: { basket } }) => {
  const csrfToken = document
    .querySelector("meta[name='csrf-token']")
    .getAttribute("content");

  fetch(`/update_basket`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      "X-CSRF-Token": csrfToken,
    },
    body: JSON.stringify(basket),
  })
    .then((response) => {
      if (!response.ok) {
        throw new Error("Network response was not ok");
      }
      return response.json();
    })
    .catch((error) => {
      console.error("Error:", error);
    });
});

// Show progress bar on live navigation and form submits
topbar.config({ barColors: { 0: "#29d" }, shadowColor: "rgba(0, 0, 0, .3)" });
window.addEventListener("phx:page-loading-start", (_info) => topbar.show(300));
window.addEventListener("phx:page-loading-stop", (_info) => topbar.hide());

// connect if there are any LiveViews on the page
liveSocket.connect();

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket;
