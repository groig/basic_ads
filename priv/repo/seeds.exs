# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     BasicAds.Repo.insert!(%BasicAds.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

{:ok, categories_file} = File.open("priv/repo/categories.json", [:read, :utf8])
{:ok, categories} = IO.read(categories_file, :all) |> Jason.decode()

categories["categories"]
|> Enum.map(fn %{"name" => name, "subs" => subs} ->
  {:ok, category} = BasicAds.Repo.insert(%BasicAds.Ad.Category{name: name})

  subs
  |> Enum.map(fn name ->
    BasicAds.Repo.insert!(%BasicAds.Ad.Subcategory{name: name, category: category})
  end)
end)
