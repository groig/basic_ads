defmodule BasicAds.Ad.Subcategory do
  use Ecto.Schema
  import Ecto.Changeset
  alias BasicAds.Ad.{Advertisement, Category}

  schema "subcategories" do
    field :description, :string
    field :name, :string
    belongs_to :category, Category
    has_many :ads, Advertisement

    timestamps()
  end

  @doc false
  def changeset(subcategory, attrs) do
    subcategory
    |> cast(attrs, [:name, :description])
    |> cast_assoc(:category)
    |> validate_required([:name, :category])
  end
end
