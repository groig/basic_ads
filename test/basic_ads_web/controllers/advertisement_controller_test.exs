defmodule BasicAdsWeb.AdvertisementControllerTest do
  use BasicAdsWeb.ConnCase

  alias BasicAds.Ad

  @create_attrs %{description: "some description", title: "some title"}
  @update_attrs %{description: "some updated description", title: "some updated title"}
  @invalid_attrs %{description: nil, title: nil}

  def fixture(:advertisement) do
    {:ok, advertisement} = Ad.create_advertisement(@create_attrs)
    advertisement
  end

  describe "index" do
    test "lists all ads", %{conn: conn} do
      conn = get(conn, Routes.advertisement_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Ads"
    end
  end

  describe "new advertisement" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.advertisement_path(conn, :new))
      assert html_response(conn, 200) =~ "New Advertisement"
    end
  end

  describe "create advertisement" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.advertisement_path(conn, :create), advertisement: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.advertisement_path(conn, :show, id)

      conn = get(conn, Routes.advertisement_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Advertisement"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.advertisement_path(conn, :create), advertisement: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Advertisement"
    end
  end

  describe "edit advertisement" do
    setup [:create_advertisement]

    test "renders form for editing chosen advertisement", %{conn: conn, advertisement: advertisement} do
      conn = get(conn, Routes.advertisement_path(conn, :edit, advertisement))
      assert html_response(conn, 200) =~ "Edit Advertisement"
    end
  end

  describe "update advertisement" do
    setup [:create_advertisement]

    test "redirects when data is valid", %{conn: conn, advertisement: advertisement} do
      conn = put(conn, Routes.advertisement_path(conn, :update, advertisement), advertisement: @update_attrs)
      assert redirected_to(conn) == Routes.advertisement_path(conn, :show, advertisement)

      conn = get(conn, Routes.advertisement_path(conn, :show, advertisement))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, advertisement: advertisement} do
      conn = put(conn, Routes.advertisement_path(conn, :update, advertisement), advertisement: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Advertisement"
    end
  end

  describe "delete advertisement" do
    setup [:create_advertisement]

    test "deletes chosen advertisement", %{conn: conn, advertisement: advertisement} do
      conn = delete(conn, Routes.advertisement_path(conn, :delete, advertisement))
      assert redirected_to(conn) == Routes.advertisement_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.advertisement_path(conn, :show, advertisement))
      end
    end
  end

  defp create_advertisement(_) do
    advertisement = fixture(:advertisement)
    %{advertisement: advertisement}
  end
end
