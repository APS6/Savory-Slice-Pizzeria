defmodule SavorySliceWeb.SessionBasketController do
  alias SavorySlice.PizzaBasket
  use SavorySliceWeb, :controller

  def add(conn, params) do
    conn
    |> store_basket(params)
    # |> clear_basket()
    |> json(%{
      status: "success",
      message: "Item added to basket",
      data: get_session(conn, :basket)
    })
  end

  def set(conn, params) do
    basket = params["items"]

    put_session(conn, :basket, basket)
    |> json(%{status: "success", message: "Updated basket"})
  end

  defp store_basket(conn, pizza) do
    basket = get_session(conn, :basket) || []

    pizza =
      %{
        pizza
        | "title" => pizza["title"]
      }
      |> Map.put(
        "price_when_carted",
        PizzaBasket.get_item_price!(pizza["pizza_id"], pizza["size"], pizza["crust"])
      )

    new_basket =
      case Enum.find(basket, fn item ->
             item["pizza_id"] == pizza["pizza_id"] and item["size"] == pizza["size"] and
               item["crust"] == pizza["crust"]
           end) do
        nil ->
          [
            pizza
            | basket
          ]

        _existing_item ->
          Enum.map(basket, fn item ->
            if item["pizza_id"] == pizza["pizza_id"] and item["size"] == pizza["size"] and
                 item["crust"] == pizza["crust"] do
              updated_quantity = item["quantity"] + pizza["quantity"]
              %{item | "quantity" => updated_quantity}
            else
              item
            end
          end)
      end

    put_session(conn, :basket, new_basket)
  end

  defp clear_basket(conn) do
    put_session(conn, :basket, nil)
  end
end
