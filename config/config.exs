# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :basic_ads,
  ecto_repos: [BasicAds.Repo]

# Configures the endpoint
config :basic_ads, BasicAdsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "PCN8VUY3ByBnzLTuIb2CaFXbHpU6r1LCpuShpSUSThjm/jIGXsIX+DfVgPjekGut",
  render_errors: [view: BasicAdsWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: BasicAds.PubSub,
  live_view: [signing_salt: "pP9NUPUq"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Timezones
config :elixir, :time_zone_database, Tzdata.TimeZoneDatabase

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
