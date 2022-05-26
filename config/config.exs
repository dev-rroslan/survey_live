# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :survey_live,
  ecto_repos: [SurveyLive.Repo],
  generators: [binary_id: true]

config :survey_live, SurveyLive.Repo,
  migration_primary_key: [name: :id, type: :binary_id]

config :survey_live,
  require_user_confirmation: true,
  app_name: "SurveyLive",
  page_url: "survey_live.com",
  company_name: "SurveyLive Inc",
  company_address: "26955 Fritsch Bridge",
  company_zip: "54933-7180",
  company_city: "San Fransisco",
  company_state: "California",
  company_country: "United States",
  contact_name: "John Doe",
  contact_phone: "+1 (335) 555-2036",
  contact_email: "john.doe@survey_live.com",
  from_email: "john.doe@survey_live.com"

# Configures the endpoint
config :survey_live, SurveyLiveWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: SurveyLiveWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: SurveyLive.PubSub,
  live_view: [signing_salt: "SJDvJEHi"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :survey_live, SurveyLive.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.29",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

config :tailwind,
  version: "3.0.24",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :survey_live, SurveyLive.Admins.Guardian,
  issuer: "survey_live",
  secret_key: System.get_env("GUARDIAN_SECRET_KEY_ADMINS") || "xZDSAH/+WYriIjnH4wm0BgTebmEJYpa0vQpgUYU1iUWFSmF0CaGh4ku5OstSHwVd"

# config :survey_live, SurveyLive.Accounts.Guardian,
#   issuer: "survey_live",
#   secret_key: System.get_env("GUARDIAN_SECRET_KEY") || "ZUyVJxQNXQoME6eoNZXJsSK42aO/mqO1HUNWNBxSUU/+7rp8Wade8zzE530QksvF"

config :survey_live, Oban,
  repo: SurveyLive.Repo,
  queues: [default: 10, mailers: 20, high: 50, low: 5],
  plugins: [
    {Oban.Plugins.Pruner, max_age: (3600 * 24)},
    {Oban.Plugins.Cron,
      crontab: [
       # {"0 2 * * *", SurveyLive.Workers.DailyDigestWorker},
       # {"@reboot", SurveyLive.Workers.StripeSyncWorker}
     ]}
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
