defmodule BasicAds.Repo.Migrations.AddTsvectorsToAd do
  use Ecto.Migration

  def change do
    alter table("ads") do
      add(:search_tsv, :tsvector)
    end

    execute("CREATE EXTENSION unaccent;")

    execute("CREATE TEXT SEARCH CONFIGURATION es ( COPY = spanish );")

    execute(
      "ALTER TEXT SEARCH CONFIGURATION es ALTER MAPPING FOR hword, hword_part, word WITH unaccent, spanish_stem;"
    )

    execute(
      "UPDATE ads SET search_tsv = to_tsvector('es', coalesce(title, '') || ' ' || coalesce(description, ''))"
    )

    create(index(:ads, [:search_tsv], using: :gin))

    execute("""
    CREATE TRIGGER ad_search_tsv_trigger BEFORE INSERT OR UPDATE
    ON ads FOR EACH ROW EXECUTE PROCEDURE
    tsvector_update_trigger(search_tsv, 'pg_catalog.spanish', title, description);
    """)
  end
end
