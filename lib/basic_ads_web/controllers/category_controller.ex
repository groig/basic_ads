defmodule BasicAdsWeb.CategoryController do
  use BasicAdsWeb, :controller

  alias BasicAds.Ad

  def index(conn, _params) do
    categories = Ad.list_categories()
    render(conn, "index.html", categories: categories)
  end
end
