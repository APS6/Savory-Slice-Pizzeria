defmodule SavorySlice.Menu do
  @moduledoc """
  The Menu context.
  """

  import Ecto.Query, warn: false
  alias SavorySlice.Repo

  alias SavorySlice.Menu.Pizza
  alias SavorySlice.Menu.Category

  @doc """
  Returns the list of pizzas.

  ## Examples

      iex> list_pizzas()
      [%Pizza{}, ...]

  """
  def list_pizzas do
    Repo.all(Pizza)
  end

  @doc """
  Gets a single pizza.

  Raises `Ecto.NoResultsError` if the Pizza does not exist.

  ## Examples

      iex> get_pizza!(123)
      %Pizza{}

      iex> get_pizza!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pizza!(id) do
    Pizza |> Repo.get!(id) |> Repo.preload(:categories)
  end

  @doc """
  Creates a pizza.

  ## Examples

      iex> create_pizza(%{field: value})
      {:ok, %Pizza{}}

      iex> create_pizza(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_pizza(attrs \\ %{}) do
    %Pizza{}
    |> change_pizza(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a pizza.

  ## Examples

      iex> update_pizza(pizza, %{field: new_value})
      {:ok, %Pizza{}}

      iex> update_pizza(pizza, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pizza(%Pizza{} = pizza, attrs) do
    pizza
    |> change_pizza(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a pizza.

  ## Examples

      iex> delete_pizza(pizza)
      {:ok, %Pizza{}}

      iex> delete_pizza(pizza)
      {:error, %Ecto.Changeset{}}

  """
  def delete_pizza(%Pizza{} = pizza) do
    Repo.delete(pizza)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking pizza changes.

  ## Examples

      iex> change_pizza(pizza)
      %Ecto.Changeset{data: %Pizza{}}

  """
  def change_pizza(%Pizza{} = pizza, attrs \\ %{}) do
    categories = list_categories_by_id(attrs["category_ids"])

    pizza
    |> Repo.preload(:categories)
    |> Pizza.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:categories, categories)
  end

  @doc """
  Returns the list of categories.

  ## Examples

      iex> list_categories()
      [%Category{}, ...]

  """
  def list_categories do
    Repo.all(Category)
  end

  @doc """
  Returns the list of categories with their contents.

  ## Examples

      iex> list_categories_with_Pizzas()
      [%Category{}, ...]

  """
  def list_categories_with_pizzas do
    Repo.all(Category) |> Repo.preload(:pizzas)
  
  end

  @doc """
  Gets a single category.

  Raises `Ecto.NoResultsError` if the Category does not exist.

  ## Examples

      iex> get_category!(123)
      %Category{}

      iex> get_category!(456)
      ** (Ecto.NoResultsError)

  """
  def get_category!(id), do: Repo.get!(Category, id)

  @doc """
  Creates a category.

  ## Examples

      iex> create_category(%{field: value})
      {:ok, %Category{}}

      iex> create_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_category(attrs \\ %{}) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a category.

  ## Examples

      iex> update_category(category, %{field: new_value})
      {:ok, %Category{}}

      iex> update_category(category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_category(%Category{} = category, attrs) do
    category
    |> Category.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a category.

  ## Examples

      iex> delete_category(category)
      {:ok, %Category{}}

      iex> delete_category(category)
      {:error, %Ecto.Changeset{}}

  """
  def delete_category(%Category{} = category) do
    Repo.delete(category)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking category changes.

  ## Examples

      iex> change_category(category)
      %Ecto.Changeset{data: %Category{}}

  """
  def change_category(%Category{} = category, attrs \\ %{}) do
    Category.changeset(category, attrs)
  end

  def list_categories_by_id(nil), do: []

  def list_categories_by_id(category_ids) do
    Repo.all(from c in Category, where: c.id in ^category_ids)
  end
end
