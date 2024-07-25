defmodule SavorySlice.Repo.Migrations.CreateBaskets do
  use Ecto.Migration

  def change do
    create table(:baskets) do
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create unique_index(:baskets, [:user_id])
  end
end
