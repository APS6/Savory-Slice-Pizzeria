defmodule SavorySlice.Repo.Migrations.AddSizePricesToPizza do
  use Ecto.Migration

  def change do
    alter table(:pizzas) do
      add :medium_price, :decimal, precision: 5, scale: 2
      add :large_price, :decimal, precision: 5, scale: 2
    end
  end
end
