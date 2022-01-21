defmodule UrlShortenerWeb.LinkController do
  @moduledoc """
  Link Endpoints
  """
  use UrlShortenerWeb, :controller

  alias UrlShortener.{Link, Links, Repo}

  @spec index(Plug.Conn.t(), map()) :: Phoenix.HTML.t()
  def index(conn, _params) do
    links = Links.get_last_links()

    render(conn, "index.html", links: links)
  end

  @spec new(Plug.Conn.t(), map()) :: Phoenix.HTML.t()
  def new(conn, _params) do
    changeset = Link.changeset(%Link{})

    render(conn, "new.html", changeset: changeset, errors: [])
  end

  @spec create(Plug.Conn.t(), map()) :: Phoenix.HTML.t()
  def create(conn, %{"link" => attributes}) do
    case Links.create_link(attributes) do
      {:ok, _link} ->
        conn
        |> put_flash(:info, "Short URL created with success!")
        |> redirect(to: Routes.link_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(422)
        |> render("new.html", changeset: changeset, errors: changeset.errors)
    end
  end

  @spec show(Plug.Conn.t(), map()) :: Phoenix.HTML.t()
  def show(conn, %{"id" => id}) do
    case Repo.get(Link, id) do
      nil ->
        conn
        |> put_status(:not_found)
        |> put_view(UrlShortenerWeb.ErrorView)
        |> render("404.html")

      link ->
        redirect(conn, external: link.url)
    end
  end
end
