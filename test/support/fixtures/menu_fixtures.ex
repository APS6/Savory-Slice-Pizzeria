defmodule SavorySlice.MenuFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SavorySlice.Menu` context.
  """

  @doc """
  Generate a pizza.
  """
  def pizza_fixture(attrs \\ %{}) do
    {:ok, pizza} =
      attrs
      |> Enum.into(%{
        description: "some description",
        full_price: "some full_price",
        imgUrl: "some imgUrl",
        price: "some price",
        title: "some title",
        veg: true
      })
      |> SavorySlice.Menu.create_pizza()

    pizza
  end

  @doc """
  Generate a unique category title.
  """
  def unique_category_title, do: "some title#{System.unique_integer([:positive])}"

  @doc """
  Generate a category.
  """
  def category_fixture(attrs \\ %{}) do
    {:ok, category} =
      attrs
      |> Enum.into(%{
        title: unique_category_title()
      })
      |> SavorySlice.Menu.create_category()

    category
  end
end
