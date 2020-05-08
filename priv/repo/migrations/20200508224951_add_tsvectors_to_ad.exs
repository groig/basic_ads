defmodule BasicAds.Repo.Migrations.AddTsvectorsToAd do
  use Ecto.Migration

  def change do
    alter table("ads") do
      add(:search_tsv, :tsvector)
    end

    execute(
      "UPDATE ads SET search_tsv = to_tsvector('spanish', COALESCE(title, '') || ' ' || COALESCE(description, ''))"
    )

    create(index(:ads, [:search_tsv], using: :gin))

    execute("""
    CREATE TRIGGER ad_search_tsv_trigger BEFORE INSERT OR UPDATE
    ON ads FOR EACH ROW EXECUTE PROCEDURE
    tsvector_update_trigger(search_tsv, 'pg_catalog.spanish', title, description);
    """)
  end
end
