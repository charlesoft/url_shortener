defmodule UrlShortenerWeb.LinkViewTest do
  use UrlShortenerWeb.ConnCase, async: true

  alias UrlShortener.Links
  alias UrlShortenerWeb.LinkView

  import UrlShortener.Factory

  describe "link_url/1" do
    test "renders the link's short URL" do
      link = insert(:link)

      assert LinkView.link_url(link) == UrlShortenerWeb.Endpoint.url() <> "/#{link.id}"
    end
  end

  describe "created_at" do
    test "renders the datetime created for the link in a relative format" do
      inserted_at = %{
        NaiveDateTime.add(NaiveDateTime.utc_now(), 60, :second)
        | microsecond: {0, 0}
      }

      link = insert(:link, inserted_at: inserted_at)

      assert LinkView.created_at(link) == "in 1 minute"
    end
  end

  describe "get_errors/0" do
    test "renders errors" do
      {:error, changeset} = Links.create_link(%{"url" => "invalid_url"})

      assert LinkView.get_errors(changeset.errors) == ["invalid URL"]
    end

    test "returns nil if it's not a list" do
      assert LinkView.get_errors("") == nil
    end
  end
end
