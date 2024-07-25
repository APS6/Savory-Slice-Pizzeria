defmodule SavorySlice.Repo.Migrations.CreateBasketItems do
  use Ecto.Migration

  def change do
    create table(:basket_items) do
      add :price_when_carted, :decimal, precision: 5, scale: 2, null: false
      add :quantity, :integer
      add :size, :string
      add :crust, :string
      add :basket_id, references(:baskets, on_delete: :delete_all)
      add :pizza_id, references(:pizzas, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:basket_items, [:basket_id])
    create index(:basket_items, [:pizza_id])
    create unique_index(:basket_items, [:basket_id, :pizza_id])
  end
end
