defmodule BasicAds.AdTest do
  use BasicAds.DataCase

  alias BasicAds.Ad

  describe "ads" do
    alias BasicAds.Ad.Advertisement

    @valid_attrs %{description: "some description", title: "some title"}
    @update_attrs %{description: "some updated description", title: "some updated title"}
    @invalid_attrs %{description: nil, title: nil}

    def advertisement_fixture(attrs \\ %{}) do
      {:ok, advertisement} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Ad.create_advertisement()

      advertisement
    end

    test "list_ads/0 returns all ads" do
      advertisement = advertisement_fixture()
      assert Ad.list_ads() == [advertisement]
    end

    test "get_advertisement!/1 returns the advertisement with given id" do
      advertisement = advertisement_fixture()
      assert Ad.get_advertisement!(advertisement.id) == advertisement
    end

    test "create_advertisement/1 with valid data creates a advertisement" do
      assert {:ok, %Advertisement{} = advertisement} = Ad.create_advertisement(@valid_attrs)
      assert advertisement.description == "some description"
      assert advertisement.title == "some title"
    end

    test "create_advertisement/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ad.create_advertisement(@invalid_attrs)
    end

    test "update_advertisement/2 with valid data updates the advertisement" do
      advertisement = advertisement_fixture()
      assert {:ok, %Advertisement{} = advertisement} = Ad.update_advertisement(advertisement, @update_attrs)
      assert advertisement.description == "some updated description"
      assert advertisement.title == "some updated title"
    end

    test "update_advertisement/2 with invalid data returns error changeset" do
      advertisement = advertisement_fixture()
      assert {:error, %Ecto.Changeset{}} = Ad.update_advertisement(advertisement, @invalid_attrs)
      assert advertisement == Ad.get_advertisement!(advertisement.id)
    end

    test "delete_advertisement/1 deletes the advertisement" do
      advertisement = advertisement_fixture()
      assert {:ok, %Advertisement{}} = Ad.delete_advertisement(advertisement)
      assert_raise Ecto.NoResultsError, fn -> Ad.get_advertisement!(advertisement.id) end
    end

    test "change_advertisement/1 returns a advertisement changeset" do
      advertisement = advertisement_fixture()
      assert %Ecto.Changeset{} = Ad.change_advertisement(advertisement)
    end
  end
end
