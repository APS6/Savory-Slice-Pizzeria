defmodule SavorySlice.Repo do
  use Ecto.Repo,
    otp_app: :savory_slice,
    adapter: Ecto.Adapters.Postgres
end
