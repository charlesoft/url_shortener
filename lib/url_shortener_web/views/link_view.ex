defmodule UrlShortenerWeb.LinkView do
  use UrlShortenerWeb, :view

  alias UrlShortener.Link

  def link_url(%Link{id: id}) do
    UrlShortenerWeb.Endpoint.url() <> "/#{id}"
  end
end