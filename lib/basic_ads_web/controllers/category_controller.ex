defmodule BasicAdsWeb.CategoryController do
  use BasicAdsWeb, :controller

  alias BasicAds.Ad

  plug :show_search when action in [:index]

  defp show_search(conn, _) do
    assign(conn, :show_search, true)
  end

  def index(conn, _params) do
    categories = Ad.list_categories()
    render(conn, "index.html", categories: categories)
  end
end
