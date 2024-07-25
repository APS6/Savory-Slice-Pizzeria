defmodule SavorySliceWeb.PizzaHTML do
  use SavorySliceWeb, :html

  embed_templates "pizza_html/*"

  @doc """
  Renders a pizza form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def pizza_form(assigns)
end
