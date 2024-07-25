defmodule SavorySliceWeb.SessionBasketController do
  alias SavorySlice.PizzaBasket
  use SavorySliceWeb, :controller

  def set(conn, params) do
    basket = params["items"]

    put_session(conn, :basket, basket)
    |> json(%{status: "success", message: "Updated basket"})
  end

  defp clear_basket(conn) do
    put_session(conn, :basket, nil)
  end
end
