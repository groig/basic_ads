defmodule BasicAdsWeb.AdvertisementView do
  use BasicAdsWeb, :view
  def title("new.html", _assigns), do: "Nuevo Anuncio"
  def title("index.html", _assigns), do: "Anuncios Clasificados"
  def title("show.html", assigns), do: assigns.advertisement.title
end
