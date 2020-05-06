defmodule BasicAdsWeb.SubcategoryController do
  use BasicAdsWeb, :controller

  alias BasicAds.Ad

  def index(conn, _params) do
    ads = Ad.list_ads()
    render(conn, "index.html", ads: ads)
  end
end
