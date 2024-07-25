defmodule SavorySlice.PizzaBasket.BasketItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "basket_items" do
    field :price_when_carted, :decimal
    field :quantity, :integer
    field :size, :string
    field :crust, :string

    belongs_to :basket, SavorySlice.PizzaBasket.Basket
    belongs_to :pizza, SavorySlice.Menu.Pizza

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(basket_item, attrs) do
    basket_item
    |> cast(attrs, [:price_when_carted, :quantity, :size, :crust])
    |> validate_required([:price_when_carted, :quantity, :size, :crust])
    |> validate_inclusion(:size, ["regular", "medium", "large"])
    |> validate_inclusion(:crust, ["free", "pan", "cheese"])
  end
end
