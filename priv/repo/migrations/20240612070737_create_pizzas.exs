defmodule SavorySlice.Repo.Migrations.CreatePizzas do
  use Ecto.Migration

  def change do
    create table(:pizzas) do
      add :title, :string, null: false
      add :imgUrl, :string, null: false
      add :description, :string, null: false
      add :full_price, :decimal, precision: 5, scale: 2, null: false
      add :price, :decimal, precision: 5, scale: 2, null: false
      add :veg, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
