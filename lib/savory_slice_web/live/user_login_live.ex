defmodule SavorySliceWeb.UserLoginLive do
  use SavorySliceWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="mx-auto h-[calc(100lvh-64px)] grid place-items-center max-w-sm">
      <div>
        <.header class="text-center">
          Log in to account
        </.header>

        <.simple_form for={@form} id="login_form" action={~p"/users/log_in"} phx-update="ignore">
          <.input field={@form[:email]} type="email" label="Email" required />
          <.input field={@form[:password]} type="password" label="Password" required />

          <:actions>
            <.input field={@form[:remember_me]} type="checkbox" label="Keep me logged in" />
            <.link href={~p"/users/reset_password"} class="text-sm font-semibold">
              Forgot your password?
            </.link>
          </:actions>
          <:actions>
            <.button
              phx-disable-with="Logging in..."
              class="w-full bg-black text-white py-2 rounded-lg"
            >
              Log in <span aria-hidden="true">→</span>
            </.button>
          </:actions>
        </.simple_form>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    email = Phoenix.Flash.get(socket.assigns.flash, :email)
    form = to_form(%{"email" => email}, as: "user")
    {:ok, assign(socket, form: form), temporary_assigns: [form: form]}
  end
end
