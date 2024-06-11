defmodule SavorySlice.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      SavorySliceWeb.Telemetry,
      SavorySlice.Repo,
      {DNSCluster, query: Application.get_env(:savory_slice, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: SavorySlice.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: SavorySlice.Finch},
      # Start a worker by calling: SavorySlice.Worker.start_link(arg)
      # {SavorySlice.Worker, arg},
      # Start to serve requests, typically the last entry
      SavorySliceWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SavorySlice.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SavorySliceWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
