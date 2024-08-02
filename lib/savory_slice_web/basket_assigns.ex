defmodule SavorySliceWeb.BasketAssigns do
  import Phoenix.Component

  def on_mount(:mount_current_basket, _params, session, socket) do
    IO.puts(session["test"])
    {:cont, mount_current_basket(socket, session)}
  end

  defp mount_current_basket(socket, session) do
    if session["basket"] do
      assign(socket, :basket, %{items: session["basket"]})
    else
      assign(socket, :basket, nil)
    end
  end
end
