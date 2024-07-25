defmodule SavorySlice.Menu.Pizza do
  use Ecto.Schema
  import Ecto.Changeset
  alias SavorySlice.Menu.Category

  schema "pizzas" do
    field :description, :string
    field :title, :string
    field :imgUrl, :string
    field :full_price, :decimal
    field :price, :decimal
    field :medium_price, :decimal
    field :large_price, :decimal
    field :veg, :boolean, default: false

    many_to_many :categories, Category, join_through: "pizza_categories", on_replace: :delete

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(pizza, attrs) do
    pizza
    |> cast(attrs, [
      :title,
      :imgUrl,
      :description,
      :full_price,
      :price,
      :medium_price,
      :large_price,
      :veg
    ])
    |> validate_required([:title, :imgUrl, :description, :full_price, :price, :veg])
  end
end
