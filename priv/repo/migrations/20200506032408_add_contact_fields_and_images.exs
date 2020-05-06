defmodule BasicAds.Repo.Migrations.AddContactFieldsAndImages do
  use Ecto.Migration

  def change do
    alter table(:ads) do
      add(:phone, :string)
      add(:email, :string)
      add(:image1, :string)
      add(:image2, :string)
      add(:image3, :string)
      modify(:description, :text)
    end
  end
end
