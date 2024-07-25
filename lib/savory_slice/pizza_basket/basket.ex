defmodule SavorySlice.PizzaBasket.Basket do
  use Ecto.Schema
  import Ecto.Changeset

  schema "baskets" do
    field :user_id, :string

    has_many :items, SavorySlice.PizzaBasket.BasketItem

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(basket, attrs) do
    basket
    |> cast(attrs, [:user_id])
    |> validate_required([:user_id])
    |> unique_constraint(:user_id)
  end
end
