defmodule BasicAds.Repo.Migrations.AddPriceToAd do
  use Ecto.Migration

  def change do
    alter table(:ads) do
      add(:price, :integer)
    end
  end
end
