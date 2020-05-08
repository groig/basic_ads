defmodule BasicAds.Ad do
  @moduledoc """
  The Ad context.
  """

  import Ecto.Query, warn: false
  alias BasicAds.Repo
  alias BasicAds.Ad.Category

  alias BasicAds.Ad.{Advertisement, Category, Subcategory}

  defp ad_query do
    Advertisement |> order_by(desc: :inserted_at) |> preload(subcategory: :category)
  end

  defp ad_search(query, search_term) do
    where(
      query,
      [ad],
      ilike(ad.title, ^"%#{search_term}%") or ilike(ad.description, ^"%#{search_term}%")
    )
  end

  def list_ads do
    ad_query() |> Repo.all()
  end

  def list_ads(search_term) do
    ad_query()
    |> ad_search(search_term)
    |> Repo.all()
  end

  defp ad_join(query, category_id) do
    join(query, :left, [ad], sub in Subcategory, on: sub.id == ad.subcategory_id)
    |> where([ad, sub], sub.category_id == ^category_id)
  end

  def list_ads_category(category_id) do
    ad_query() |> ad_join(category_id) |> Repo.all()
  end

  def list_ads_category(category_id, search_term) do
    ad_query()
    |> ad_join(category_id)
    |> ad_search(search_term)
    |> Repo.all()
  end

  def list_ads_subcategory(subcategory_id) do
    ad_query()
    |> where([ad], ad.subcategory_id == ^subcategory_id)
    |> Repo.all()
  end

  def list_ads_subcategory(subcategory_id, search_term) do
    ad_query()
    |> where([ad], ad.subcategory_id == ^subcategory_id)
    |> ad_search(search_term)
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
