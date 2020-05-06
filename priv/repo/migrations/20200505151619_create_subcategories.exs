defmodule BasicAds.Repo.Migrations.CreateSubcategories do
  use Ecto.Migration

  def change do
    create table(:subcategories) do
      add :name, :string
      add :description, :string
      add :category_id, references(:categories, on_delete: :nothing)

      timestamps()
    end

    create index(:subcategories, [:category_id])
  end
end
