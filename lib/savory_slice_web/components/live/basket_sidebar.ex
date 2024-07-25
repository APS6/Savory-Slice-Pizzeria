defmodule BasketSidebar do
  use SavorySliceWeb, :live_component

  def render(assigns) do
    ~H"""
    <div class=" hidden md:block fixed top-[61px] w-[320px] bottom-0 right-0 bg-white border-l border-l-black">
      <div class="pt-4 pb-2 h-full flex flex-col justify-between items-center">
        <div class="w-full">
          <h1 class=" text-2xl m-auto w-fit">Your Basket</h1>
          <div class="mt-3">
            <%= if @basket do %>
              <%= for i <- @basket.items do %>
                <div class="px-2 mb-1 flex justify-between">
                  <div>
                    <h3 class="text-xl"><%= i["title"] %></h3>
                    <span>
                      <%= String.capitalize(i["size"]) %> | <%= String.capitalize(i["crust"]) %>
                    </span>
                    <span class="block"><%= i["price_when_carted"] %>$</span>
                  </div>
                  <div class="flex flex-col items-end pt-1">
                    <div class="border-tomato border rounded-lg flex items-center gap-1 py-1 text-xl">
                      <div
                        phx-click="decQuantity"
                        phx-value-pizza_id={i["pizza_id"]}
                        phx-value-size={i["size"]}
                        phx-value-crust={i["crust"]}
                        class="flex-1 h-full px-3 cursor-pointer grid place-items-center text-tomato select-none"
                      >
                        -
                      </div>
                      <div><%= i["quantity"] %></div>
                      <div
                        phx-click="incQuantity"
                        phx-value-pizza_id={i["pizza_id"]}
                        phx-value-size={i["size"]}
                        phx-value-crust={i["crust"]}
                        class="flex-1 h-full px-3 cursor-pointer grid place-items-center text-tomato select-none"
                      >
                        +
                      </div>
                    </div>
                    <span class="text-lg">
                      <%= Decimal.mult(i["price_when_carted"], Decimal.new(i["quantity"])) %>$
                    </span>
                  </div>
                </div>
              <% end %>
            <% else %>
              <div class="w-full grid place-items-center">
                <p>Your basket is empty</p>
              </div>
            <% end %>
          </div>
        </div>
        <button class="bg-tomato text-white text-lg py-2 px-8 w-3/4 rounded-lg">
          Checkout - 69$
        </button>
      </div>
    </div>
    """
  end
end
