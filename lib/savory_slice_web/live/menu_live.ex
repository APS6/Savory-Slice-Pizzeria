defmodule SavorySliceWeb.MenuLive do
  use SavorySliceWeb, :live_view
  alias SavorySlice.Menu

  on_mount {SavorySliceWeb.UserAuth, :mount_current_user}
  on_mount {SavorySliceWeb.BasketAssigns, :mount_current_basket}

  def mount(_params, _session, socket) do
    categories = Menu.list_categories_with_pizzas()

    {:ok,
     assign(socket,
       categories: categories,
       modal_pizza: nil,
       show_address_dialog: false,
       address_form: nil,
       basket: socket.assigns.basket
     )}
  end

  def handle_event(
        "add_basket_item",
        %{
          "id" => pizza_id,
          "title" => title,
          "size" => size,
          "crust" => crust,
          "quantity" => quantity
        },
        socket
      ) do
    old_items = (socket.assigns.basket && socket.assigns.basket.items) || []

    new_item = %{
      "pizza_id" => pizza_id,
      "title" => title,
      "size" => size,
      "crust" => crust,
      "quantity" => String.to_integer(quantity),
      "price_when_carted" => Menu.get_item_price!(pizza_id, size, crust)
    }

    basket = %{
      items:
        case Enum.find(old_items, fn item ->
               item["pizza_id"] == pizza_id and item["size"] == size and item["crust"] == crust
             end) do
          nil ->
            [
              new_item
              | old_items
            ]

          _existing_item ->
            Enum.map(old_items, fn item ->
              if item["pizza_id"] == pizza_id and item["size"] == size and
                   item["crust"] == crust do
                %{item | "quantity" => item["quantity"] + new_item["quantity"]}
              else
                item
              end
            end)
        end,
      temporary: true
    }

    {:noreply,
     assign(
       socket
       |> LiveToast.put_toast(:info, "Item added to your basket", action: &viewbtn/1)
       |> push_event("setSessionBasket", %{basket: basket}),
       modal_pizza: nil,
       basket: basket
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

  def handle_event("show_modal", %{"pizza_id" => pizza_id}, socket) do
    modal_pizza = Menu.get_pizza!(pizza_id)
    {:noreply, assign(socket, modal_pizza: modal_pizza)}
  end

  def handle_event("hide_modal", _params, socket) do
    {:noreply, assign(socket, modal_pizza: nil)}
  end

  def handle_event("show_address_dialog", _params, socket) do
    form = to_form(%{"name" => nil, "mobile" => nil, "address" => nil, "address_2" => nil})
    {:noreply, assign(socket, show_address_dialog: true, address_form: form)}
  end

  def handle_event("hide_address_dialog", _params, socket) do
    {:noreply, assign(socket, show_address_dialog: false, address_form: nil)}
  end

  def viewbtn(assigns) do
    ~H"""
    <.link
      class="md:hidden my-4 mr-4 font-medium bg-zinc-900 text-zinc-100 px-4 py-1 rounded hover:bg-zinc-800 hover:text-zinc-200"
      navigate={~p"/basket"}
    >
      View
    </.link>
    """
  end
end
