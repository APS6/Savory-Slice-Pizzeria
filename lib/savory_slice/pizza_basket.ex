defmodule SavorySlice.PizzaBasket do
  @moduledoc """
  The PizzaBasket context.
  """

  import Ecto.Query, warn: false
  alias SavorySlice.Repo

  alias SavorySlice.Menu
  alias SavorySlice.PizzaBasket.{Basket, BasketItem}

  @doc """
  Returns the list of baskets.

  ## Examples

      iex> list_baskets()
      [%Basket{}, ...]

  """
  def list_baskets do
    Repo.all(Basket)
  end

  @doc """
  Gets a single basket.

  Raises `Ecto.NoResultsError` if the Basket does not exist.

  ## Examples

      iex> get_basket!(123)
      %Basket{}

      iex> get_basket!(456)
      ** (Ecto.NoResultsError)

  """
  def get_basket!(user_id) do
    Repo.one(
      from(b in Basket,
        where: b.user_id == ^user_id,
        left_join: i in assoc(b, :items),
        left_join: p in assoc(i, :product),
        order_by: [asc: i.inserted_at],
        preload: [items: {i, product: p}]
      )
    )
  end

  @doc """
  Creates a basket.

  ## Examples

      iex> create_basket(%{field: value})
      {:ok, %Basket{}}

      iex> create_basket(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_basket(user_id) do
    %Basket{user_id: user_id}
    |> Basket.changeset(%{})
    |> Repo.insert()
    |> case do
      {:ok, basket} -> {:ok, reload_basket(basket)}
      {:error, changeset} -> {:error, changeset}
    end
  end

  defp reload_basket(%Basket{} = basket), do: get_basket!(basket.user_id)

  @doc """
  Updates a basket.

  ## Examples

      iex> update_basket(basket, %{field: new_value})
      {:ok, %Basket{}}

      iex> update_basket(basket, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_basket(%Basket{} = basket, attrs) do
    basket
    |> Basket.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a basket.

  ## Examples

      iex> delete_basket(basket)
      {:ok, %Basket{}}

      iex> delete_basket(basket)
      {:error, %Ecto.Changeset{}}

  """
  def delete_basket(%Basket{} = basket) do
    Repo.delete(basket)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking basket changes.

  ## Examples

      iex> change_basket(basket)
      %Ecto.Changeset{data: %Basket{}}

  """
  def change_basket(%Basket{} = basket, attrs \\ %{}) do
    Basket.changeset(basket, attrs)
  end

  @doc """
  Returns the list of basket_items.

  ## Examples

      iex> list_basket_items()
      [%BasketItem{}, ...]

  """
  def list_basket_items do
    Repo.all(BasketItem)
  end

  @doc """
  Gets a single basket_item.

  Raises `Ecto.NoResultsError` if the Basket item does not exist.

  ## Examples

      iex> get_basket_item!(123)
      %BasketItem{}

      iex> get_basket_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_basket_item!(id), do: Repo.get!(BasketItem, id)

  @doc """
  Creates a basket_item.

  ## Examples

      iex> create_basket_item(%{field: value})
      {:ok, %BasketItem{}}

      iex> create_basket_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_basket_item(attrs \\ %{}) do
    %BasketItem{}
    |> BasketItem.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a basket_item.

  ## Examples

      iex> update_basket_item(basket_item, %{field: new_value})
      {:ok, %BasketItem{}}

      iex> update_basket_item(basket_item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_basket_item(%BasketItem{} = basket_item, attrs) do
    basket_item
    |> BasketItem.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a basket_item.

  ## Examples

      iex> delete_basket_item(basket_item)
      {:ok, %BasketItem{}}

      iex> delete_basket_item(basket_item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_basket_item(%BasketItem{} = basket_item) do
    Repo.delete(basket_item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking basket_item changes.

  ## Examples

      iex> change_basket_item(basket_item)
      %Ecto.Changeset{data: %BasketItem{}}

  """
  def change_basket_item(%BasketItem{} = basket_item, attrs \\ %{}) do
    BasketItem.changeset(basket_item, attrs)
  end

  def add_item_to_basket(%Basket{} = basket, pizza_id, size, crust, quantity) do
    pizza = Menu.get_pizza!(pizza_id)
    price = calculate_price(pizza, size, crust)

    %BasketItem{price_when_carted: price, quantity: quantity, size: size, crust: crust}
    |> BasketItem.changeset(%{})
    |> Ecto.Changeset.put_assoc(:basket, basket)
    |> Ecto.Changeset.put_assoc(:pizza, pizza)
    |> Repo.insert(on_conflict: [inc: [quantity: 1]], conflict_target: [:cart_id, :pizza_id])
  end

  @doc """
  Gets item price.

  ## Examples

      iex> get_basket!(id, size, crust)

  """
  def get_item_price!(pizza_id, size, crust) do
    pizza = Menu.get_pizza!(pizza_id)
    calculate_price(pizza, size, crust)
  end

  defp calculate_price(pizza, size, crust) do
    base_price =
      case size do
        :regular -> pizza.price
        :medium -> pizza.medium_price
        :large -> pizza.large_price
        "regular" -> pizza.price
        "medium" -> pizza.medium_price
        "large" -> pizza.large_price
      end

    crust_price =
      case crust do
        :free -> Decimal.new("0.0")
        :pan -> Decimal.new("0.6")
        :cheese -> Decimal.new("1.0")
        "free" -> Decimal.new("0.0")
        "pan" -> Decimal.new("0.6")
        "cheese" -> Decimal.new("1.0")
      end

    Decimal.add(base_price, crust_price)
  end
end
