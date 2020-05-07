defmodule BasicAds.Ad do
  @moduledoc """
  The Ad context.
  """

  import Ecto.Query, warn: false
  alias BasicAds.Repo
  alias BasicAds.Ad.Category

  alias BasicAds.Ad.{Advertisement, Category, Subcategory}

  def list_ads do
    Repo.all(Advertisement) |> Repo.preload(subcategory: :category)
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
