# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :dogcast,
  ecto_repos: [Dogcast.Repo]

# Configures the endpoint
config :dogcast, DogcastWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "QOYliPcrq85iN9qrdrZUwP9abO/dRJNSL8n0z7Dy77EJuo5XYD2sMh9nnTHpeoNQ",
  render_errors: [view: DogcastWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Dogcast.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
