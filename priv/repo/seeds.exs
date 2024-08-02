# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     SavorySlice.Repo.insert!(%SavorySlice.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias SavorySlice.Repo
alias SavorySlice.Accounts.User

Repo.delete_all(User)

admin_users = [
  %{email: "anirudhapsah@gmail.com", password: System.get_env("ADMIN_PASSWORD")}
]

Enum.each(admin_users, fn user_attrs ->
  %User{}
  |> User.registration_changeset(user_attrs)
  |> Repo.insert!()
end)
