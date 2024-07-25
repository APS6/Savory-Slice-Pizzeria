defmodule SavorySliceWeb.BasketAssigns do
  import Phoenix.Component

  alias SavorySlice.PizzaBasket

  def on_mount(:mount_current_basket, _params, session, socket) do
    IO.puts(session["test"])
    {:cont, mount_current_basket(socket, session)}
  end

  defp mount_current_basket(socket, session) do
    if socket.assigns.current_user do
      if basket = PizzaBasket.get_basket!(socket.assigns.current_user) do
        assign(socket, :basket, basket)
      else
        {:ok, new_basket} = PizzaBasket.create_basket(socket.assigns.current_user.id)
        assign(socket, :basket, new_basket)
      end
    else
      if session["basket"] do
        assign(socket, :basket, %{items: session["basket"], temporary: true})
      else
        assign(socket, :basket, nil)
      end
    end
  end
end
