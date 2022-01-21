defmodule UrlShortenerWeb.LinkControllerTest do
  use UrlShortenerWeb.ConnCase

  alias UrlShortener.{Link, Repo}

  import Ecto.Query
  import UrlShortener.Factory

  describe "GET :new" do
    test "renders the form to create a URL", %{conn: conn} do
      conn = get(conn, Routes.link_path(conn, :new))

      response = html_response(conn, 200)

      assert response =~ "Create your URL"
      assert response =~ "Make short URL"
    end
  end

  describe "POST :create" do
    test "creates a link with short URL", %{conn: conn} do
      url = "https://websitetest.com"
      params = %{"url" => url}

      conn = post(conn, Routes.link_path(conn, :create, %{"link" => params}))
      assert html_response(conn, 302)

      conn = get(conn, Routes.link_path(conn, :index))
      response = html_response(conn, 200)

      query = from l in Link, order_by: [desc: l.inserted_at], limit: 1
      [link] = Repo.all(query)

      assert response =~ UrlShortenerWeb.Endpoint.url() <> "/#{link.id}"
    end

    test "renders error with invalid URL", %{conn: conn} do
      invalid_url = "httpsinvalid_url"
      params = %{"url" => invalid_url}

      conn = post(conn, Routes.link_path(conn, :create, %{"link" => params}))
      response = html_response(conn, 422)

      assert response =~ "invalid URL"
    end
  end

  describe "GET :show" do
    test "redirects to the link's URL given the its ID", %{conn: conn} do
      link = insert(:link)

      conn = get(conn, Routes.link_path(conn, :show, link))

      assert html_response(conn, 302)
      assert get_resp_header(conn, "location") == [link.url]
    end

    test "returns 404 given an unknown ID", %{conn: conn} do
      id = "unknown_id"

      conn = get(conn, Routes.link_path(conn, :show, id))

      assert conn.status == 404
    end
  end
end
