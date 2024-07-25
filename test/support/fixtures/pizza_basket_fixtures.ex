defmodule SavorySlice.PizzaBasketFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SavorySlice.PizzaBasket` context.
  """

  @doc """
  Generate a unique basket user_id.
  """
  def unique_basket_user_id, do: "some user_id#{System.unique_integer([:positive])}"

  @doc """
  Generate a basket.
  """
  def basket_fixture(attrs \\ %{}) do
    {:ok, basket} =
      attrs
      |> Enum.into(%{
        user_id: unique_basket_user_id()
      })
      |> SavorySlice.PizzaBasket.create_basket()

    basket
  end

  @doc """
  Generate a basket_item.
  """
  def basket_item_fixture(attrs \\ %{}) do
    {:ok, basket_item} =
      attrs
      |> Enum.into(%{
        price_when_carted: "120.5",
        quantity: 42
      })
      |> SavorySlice.PizzaBasket.create_basket_item()

    basket_item
  end
end
