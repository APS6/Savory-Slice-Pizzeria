defmodule SavorySliceWeb.MenuLive do
  use SavorySliceWeb, :live_view
  alias SavorySlice.Menu
  alias SavorySlice.PizzaBasket

  on_mount {SavorySliceWeb.UserAuth, :mount_current_user}
  on_mount {SavorySliceWeb.BasketAssigns, :mount_current_basket}

  def mount(_params, _session, socket) do
    categories = Menu.list_categories_with_pizzas()

    {:ok,
     assign(socket,
       categories: categories,
       modal_pizza: nil,
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
    if socket.assigns.basket && !socket.assigns.basket.temporary do
      case PizzaBasket.add_item_to_basket(
             socket.assigns.basket,
             pizza_id,
             size,
             crust,
             quantity
           ) do
        {:ok, _item} ->
          {:noreply,
           assign(socket |> put_flash(:info, "Item added to your basket."),
             modal_pizza: nil,
             basket: PizzaBasket.get_basket!(socket.assigns.current_user)
           )}

        {:error, _changeset} ->
          {:noreply,
           assign(socket |> put_flash(:error, "Failed to add item to your basket"),
             modal_pizza: nil
           )}
      end
    else
      old_items = (socket.assigns.basket && socket.assigns.basket.items) || []

      new_item = %{
        "pizza_id" => pizza_id,
        "title" => title,
        "size" => size,
        "crust" => crust,
        "quantity" => String.to_integer(quantity),
        "price_when_carted" => PizzaBasket.get_item_price!(pizza_id, size, crust)
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
  end

  def handle_event(
        "incQuantity",
        %{"pizza_id" => pizza_id, "crust" => crust, "size" => size},
        socket
      ) do
    if socket.assigns.basket && !socket.assigns.basket.temporary do
      case PizzaBasket.inc_quantity(
             socket.assigns.basket,
             pizza_id
           ) do
        {:ok, _item} ->
          {:noreply,
           assign(socket,
             basket: PizzaBasket.get_basket!(socket.assigns.current_user)
           )}

        {:error, _changeset} ->
          {:noreply, socket |> put_flash(:error, "Failed to add item to your basket")}
      end
    else
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
  end

  def handle_event(
        "decQuantity",
        %{"pizza_id" => pizza_id, "crust" => crust, "size" => size},
        socket
      ) do
    if socket.assigns.basket && !socket.assigns.basket.temporary do
      case PizzaBasket.dec_quantity(
             socket.assigns.basket,
             pizza_id
           ) do
        {:ok, _item} ->
          {:noreply,
           assign(socket,
             basket: PizzaBasket.get_basket!(socket.assigns.current_user)
           )}

        {:error, _changeset} ->
          {:noreply, socket |> put_flash(:error, "Failed to add item to your basket")}
      end
    else
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
  end

  def handle_event("show_modal", %{"pizza_id" => pizza_id}, socket) do
    modal_pizza = Menu.get_pizza!(pizza_id)
    form = to_form(%{"id" => modal_pizza.id, "size" => nil, "crust" => nil, "quantity" => nil})
    {:noreply, assign(socket, modal_pizza: modal_pizza, form: form)}
  end

  def handle_event("hide_modal", _params, socket) do
    {:noreply, assign(socket, modal_pizza: nil, form: nil)}
  end

  def viewbtn(assigns) do
    ~H"""
    <.link
      class="my-4 mr-4 font-medium bg-zinc-900 text-zinc-100 px-4 py-1 rounded hover:bg-zinc-800 hover:text-zinc-200"
      navigate={~p"/basket"}
    >
      View
    </.link>
    """
  end
end
