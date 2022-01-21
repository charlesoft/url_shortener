defmodule UrlShortener.LinksTest do
  use UrlShortener.DataCase

  alias UrlShortener.Links

  import UrlShortener.Factory

  describe "get_last_links/0" do
    test "returns last five created links" do
      links = insert_list(5, :link)

      assert Links.get_last_links() == links
    end

    test "returns empty if there are no links" do
      assert Links.get_last_links() == []
    end
  end

  describe "create_link/1" do
    test "creates a link" do
      url = "https://websitetest.com"
      attributes = %{"url" => url}

      {:ok, link} = Links.create_link(attributes)

      assert link.url == "https://websitetest.com"
    end

    test "returns an error with invalid data" do
      url = "invalid_url"
      attributes = %{"url" => url}

      {:error, changeset} = Links.create_link(attributes)

      assert changeset.errors == [url: {"invalid URL", []}]
    end
  end
end
