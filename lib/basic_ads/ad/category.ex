defmodule BasicAds.Ad.Category do
  use Ecto.Schema
  import Ecto.Changeset
  alias BasicAds.Ad.Subcategory

  schema "categories" do
    field :description, :string
    field :name, :string
    has_many :subcategories, Subcategory

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end

end
