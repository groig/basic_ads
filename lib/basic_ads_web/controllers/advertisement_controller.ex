defmodule BasicAdsWeb.AdvertisementController do
  use BasicAdsWeb, :controller

  alias BasicAds.Ad
  alias BasicAds.Ad.Advertisement

  plug :load_subcategories when action in [:new, :create, :edit, :update]
  plug :show_search when action in [:index, :index_category, :index_subcategory]

  defp load_subcategories(conn, _) do
    assign(conn, :subcategories, Ad.list_categories_formated())
  end

  defp show_search(conn, _) do
    assign(conn, :show_search, true)
  end

  def index(conn, _params) do
    search_term = Map.get(conn.query_params, "s")

    ads =
      case search_term do
        nil -> Ad.list_ads()
        search_term -> Ad.list_ads(search_term)
      end

    render(conn, "index.html", ads: ads)
  end

  def index_category(conn, %{"id" => category_id}) do
    search_term = Map.get(conn.query_params, "s")

    ads =
      case search_term do
        nil -> Ad.list_ads_category(category_id)
        search_term -> Ad.list_ads_category(category_id, search_term)
      end

    render(conn, "index.html", ads: ads)
  end

  def index_subcategory(conn, %{"id" => subcategory_id}) do
    search_term = Map.get(conn.query_params, "s")

    ads =
      case search_term do
        nil -> Ad.list_ads_subcategory(subcategory_id)
        search_term -> Ad.list_ads_subcategory(subcategory_id, search_term)
      end

    render(conn, "index.html", ads: ads)
  end

  def new(conn, _params) do
    changeset = Ad.change_advertisement(%Advertisement{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"advertisement" => advertisement_params}) do
    case Ad.create_advertisement(advertisement_params) do
      {:ok, advertisement} ->
        conn
        |> put_flash(:info, "Advertisement created successfully.")
        |> redirect(to: Routes.advertisement_path(conn, :show, advertisement))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    advertisement = Ad.get_advertisement!(id)
    render(conn, "show.html", advertisement: advertisement)
  end

  def edit(conn, %{"id" => id}) do
    advertisement = Ad.get_advertisement!(id)
    changeset = Ad.change_advertisement(advertisement)
    render(conn, "edit.html", advertisement: advertisement, changeset: changeset)
  end
end
