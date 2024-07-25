defmodule SavorySliceWeb.PizzaController do
  use SavorySliceWeb, :controller

  alias SavorySlice.Menu
  alias SavorySlice.Menu.Pizza

  def index(conn, _params) do
    pizzas = Menu.list_pizzas()
    render(conn, :index, pizzas: pizzas)
  end

  def new(conn, _params) do
    changeset = Menu.change_pizza(%Pizza{})
    categories = category_opts(changeset)
    render(conn, :new, changeset: changeset, categories: categories)
  end

  def create(conn, %{"pizza" => pizza_params}) do
    case Menu.create_pizza(pizza_params) do
      {:ok, pizza} ->
        conn
        |> put_flash(:info, "Pizza created successfully.")
        |> redirect(to: ~p"/admin/pizzas/#{pizza}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    pizza = Menu.get_pizza!(id)
    render(conn, :show, pizza: pizza)
  end

  def edit(conn, %{"id" => id}) do
    pizza = Menu.get_pizza!(id)
    changeset = Menu.change_pizza(pizza)
    categories = category_opts(changeset)
    render(conn, :edit, pizza: pizza, changeset: changeset, categories: categories)
  end

  def update(conn, %{"id" => id, "pizza" => pizza_params}) do
    pizza = Menu.get_pizza!(id)

    case Menu.update_pizza(pizza, pizza_params) do
      {:ok, pizza} ->
        conn
        |> put_flash(:info, "Pizza updated successfully.")
        |> redirect(to: ~p"/admin/pizzas/#{pizza}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, pizza: pizza, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    pizza = Menu.get_pizza!(id)
    {:ok, _pizza} = Menu.delete_pizza(pizza)

    conn
    |> put_flash(:info, "Pizza deleted successfully.")
    |> redirect(to: ~p"/admin/pizzas")
  end

 def createCategory(conn, %{"category" => category_params}) do
    case Menu.create_category(category_params) do
      {:ok, category} ->
        conn
        |> put_status(:created)
        |> json(%{category: category})

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{error: "Couldn't create category", details: changeset})
    end
  end

  defp category_opts(changeset) do
    existing_ids =
      changeset
      |> Ecto.Changeset.get_change(:categories, [])
      |> Enum.map(& &1.data.id)

    for cat <- SavorySlice.Menu.list_categories(),
        do: [key: cat.title, value: cat.id, selected: cat.id in existing_ids]
  end
end
