defmodule BasicAds.Repo.Migrations.ModifyDescriptionFieldOfSubcategory do
  use Ecto.Migration

  def change do
    alter table(:subcategories) do
      modify(:description, :text)
    end
  end
end
