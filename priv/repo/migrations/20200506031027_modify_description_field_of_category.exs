defmodule BasicAds.Repo.Migrations.ModifyDescriptionFieldOfCategory do
  use Ecto.Migration

  def change do
    alter table(:categories) do
      modify(:description, :text)
    end
  end
end
