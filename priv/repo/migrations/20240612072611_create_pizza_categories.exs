defmodule SavorySlice.Repo.Migrations.CreatePizzaCategories do
  use Ecto.Migration

  def change do
    create table(:pizza_categories, primary_key: false) do
      add :pizza_id, references(:pizzas, on_delete: :delete_all)
      add :category_id, references(:categories, on_delete: :delete_all)
    end

    create index(:pizza_categories, [:pizza_id])
    create unique_index(:pizza_categories, [:category_id, :pizza_id])
  end
end
