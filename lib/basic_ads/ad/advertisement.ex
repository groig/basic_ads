defmodule BasicAds.Ad.Advertisement do
  use Ecto.Schema
  import Ecto.Changeset
  alias BasicAds.Ad.Subcategory

  schema "ads" do
    field :title, :string
    field :description, :string
    field :price, :integer
    field :phone, :string
    field :email, :string
    field :image1, :string
    field :image2, :string
    field :image3, :string
    field :search_tsv, TSVectorType
    belongs_to :subcategory, Subcategory

    timestamps()
  end

  @doc false
  def changeset(advertisement, attrs) do
    advertisement
    |> cast(attrs, [
      :title,
      :description,
      :price,
      :phone,
      :email,
      :image1,
      :image2,
      :image3,
      :subcategory_id
    ])
    |> validate_required([:title, :subcategory_id])
  end
end

