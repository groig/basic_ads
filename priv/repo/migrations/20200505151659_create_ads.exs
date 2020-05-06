defmodule BasicAds.Repo.Migrations.CreateAds do
  use Ecto.Migration

  def change do
    create table(:ads) do
      add :title, :string
      add :description, :string
      add :subcategory_id, references(:subcategories, on_delete: :nothing)

      timestamps()
    end

    create index(:ads, [:subcategory_id])
  end
end
