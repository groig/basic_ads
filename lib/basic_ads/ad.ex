defmodule BasicAds.Ad do
  @moduledoc """
  The Ad context.
  """

  import Ecto.Query, warn: false
  alias BasicAds.Repo
  alias BasicAds.Ad.Category

  alias BasicAds.Ad.{Advertisement, Category, Subcategory}

  defmacro tsquery(field, text) do
    quote do
      fragment("?::tsvector @@ to_tsquery('spanish', ?)", unquote(field), unquote(text))
    end
  end

  defp split_names_for_tsquery(text) do
    String.split(text || "", " ", trim: true)
    # # |> Enum.reject(fn text -> Regex.match?(~r/\(|\)\[|\]\{|\}/, text) end)
    |> Enum.map(fn token -> token <> ":*" end)
    |> Enum.intersperse(" & ")
    # |> IO.inspect
    |> Enum.join()
  end

  defp ad_query do
    Advertisement |> order_by(desc: :inserted_at) |> preload(subcategory: :category)
  end

  defp ad_search(query, text) do
    n_text = split_names_for_tsquery(text)
    where(query, [ad], tsquery(ad.search_tsv, ^n_text))
    # where(
    #   query,
    #   [ad],
    #   ilike(ad.title, ^"%#{text}%") or ilike(ad.description, ^"%#{text}%")
    # )
  end

  defp ad_join(query, category_id) do
    join(query, :left, [ad], sub in Subcategory, on: sub.id == ad.subcategory_id)
    |> where([ad, sub], sub.category_id == ^category_id)
  end

  def list_ads(text) do
    ad_query()
    |> ad_search(text)
    |> Repo.all()
  end

  def list_ads_category(category_id, text) do
    ad_query()
    |> ad_join(category_id)
    |> ad_search(text)
    |> Repo.all()
  end

  def list_ads_subcategory(subcategory_id, text) do
    ad_query()
    |> where([ad], ad.subcategory_id == ^subcategory_id)
    |> ad_search(text)
    |> Repo.all()
  end

  def get_advertisement!(id),
    do: Repo.get!(Advertisement, id) |> Repo.preload(subcategory: :category)

  def get_category!(id),
    do: Repo.get!(Category, id) |> Repo.preload(subcategories: :ads)

  def get_subcategory!(id),
    do: Repo.get!(Subcategory, id) |> Repo.preload(:ads)

  def create_advertisement(attrs \\ %{}) do
    %Advertisement{}
    |> Advertisement.changeset(attrs)
    |> Repo.insert()
  end

  def update_advertisement(%Advertisement{} = advertisement, attrs) do
    advertisement
    |> Advertisement.changeset(attrs)
    |> Repo.update()
  end

  def delete_advertisement(%Advertisement{} = advertisement) do
    Repo.delete(advertisement)
  end

  def change_advertisement(%Advertisement{} = advertisement, attrs \\ %{}) do
    Advertisement.changeset(advertisement, attrs)
  end

  def list_categories do
    Repo.all(Category)
    |> Repo.preload(:subcategories)
  end

  def list_categories_formated do
    Repo.all(Category)
    |> Repo.preload(:subcategories)
    |> Enum.map(fn category ->
      subcategories =
        category.subcategories
        |> Enum.map(fn subcategory -> [key: subcategory.name, value: subcategory.id] end)

      [key: category.name, value: subcategories]
    end)
  end
end
