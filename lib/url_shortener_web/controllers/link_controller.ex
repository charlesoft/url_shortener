defmodule UrlShortenerWeb.LinkController do
  use UrlShortenerWeb, :controller

  alias UrlShortener.{Link, Links, Repo}

  def index(conn, _params) do
    links = Repo.all(Link)

    render(conn, "index.html", links: links)
  end

  def new(conn, _params) do
    changeset = Link.changeset(%Link{})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"link" => attributes}) do
    case Links.create_link(attributes) do
      {:ok, _link} ->
        conn
        |> put_flash(:info, "Short URL created with success!")
        |> redirect(to: Routes.link_path(conn, :index))

      {:error, %Ecto.Changeset{} = _changeset_error} ->
        conn
        |> put_flash(:error, "Error")
        |> redirect(to: Routes.link_path(conn, :new))
    end
  end

  def show(conn, %{"id" => id}) do
    case Repo.get(Link, id) do
      nil ->
        conn
        |> put_status(:not_found)
        |> put_view(UrlShortener.ErrorView)
        |> render("404.html")

      link ->
        redirect(conn, external: link.url)
    end
  end
end
