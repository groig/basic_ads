defmodule BasicAds.Repo do
  use Ecto.Repo,
    otp_app: :basic_ads,
    adapter: Ecto.Adapters.Postgres
end
