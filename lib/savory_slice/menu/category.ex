defmodule SavorySlice.Menu.Category do
  use Ecto.Schema
  import Ecto.Changeset
  alias SavorySlice.Menu.Pizza

 @derive {Jason.Encoder, only: [:id, :title, :inserted_at, :updated_at]}
  schema "categories" do
    field :title, :string
    many_to_many :pizzas, Pizza, join_through: "pizza_categories", on_replace: :delete
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:title])
    |> validate_required([:title])
    |> unique_constraint(:title)
  end
end
