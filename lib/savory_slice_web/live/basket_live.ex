defmodule SavorySliceWeb.BasketLive do
  use SavorySliceWeb, :live_view

  on_mount {SavorySliceWeb.UserAuth, :mount_current_user}
  on_mount {SavorySliceWeb.BasketAssigns, :mount_current_basket}

  def mount(_params, _session, socket) do
    sub_total =
      if socket.assigns.basket do
        Enum.reduce(socket.assigns.basket.items, Decimal.new(0), fn item, acc ->
          Decimal.add(acc, Decimal.mult(item["price_when_carted"], item["quantity"]))
        end)
      else
        Decimal.new(0)
      end

    total = Decimal.add(sub_total, Decimal.new(2))

    {:ok,
     assign(socket,
       modal_pizza: nil,
       basket: socket.assigns.basket,
       sub_total: sub_total,
       total: total,
       show_address_dialog: false,
       address_form: nil
     )}
  end

  def handle_event(
        "incQuantity",
        %{"pizza_id" => pizza_id, "crust" => crust, "size" => size},
        socket
      ) do
    old_items = socket.assigns.basket && socket.assigns.basket.items

    basket = %{
      items:
        Enum.map(old_items, fn item ->
          if item["pizza_id"] == pizza_id and item["size"] == size and
               item["crust"] == crust do
            %{item | "quantity" => item["quantity"] + 1}
          else
            item
          end
        end),
      temporary: true
    }

    {:noreply,
     assign(
       socket |> push_event("setSessionBasket", %{basket: basket}),
       basket: basket
     )}
  end

  def handle_event(
        "decQuantity",
        %{"pizza_id" => pizza_id, "crust" => crust, "size" => size},
        socket
      ) do
    old_items = socket.assigns.basket && socket.assigns.basket.items

    basket = %{
      items:
        old_items
        |> Enum.map(fn item ->
          if item["pizza_id"] == pizza_id and item["size"] == size and item["crust"] == crust do
            if item["quantity"] > 1 do
              %{item | "quantity" => item["quantity"] - 1}
            else
              nil
            end
          else
            item
          end
        end)
        |> Enum.filter(&(&1 != nil)),
      temporary: true
    }

    {:noreply,
     assign(
       socket |> push_event("setSessionBasket", %{basket: basket}),
       basket: basket
     )}
  end

  def handle_event("show_address_dialog", _params, socket) do
    form = to_form(%{"name" => nil, "mobile" => nil, "address" => nil, "address_2" => nil})
    {:noreply, assign(socket, show_address_dialog: true, address_form: form)}
  end

  def handle_event("hide_address_dialog", _params, socket) do
    {:noreply, assign(socket, show_address_dialog: false, address_form: nil)}
  end
end
