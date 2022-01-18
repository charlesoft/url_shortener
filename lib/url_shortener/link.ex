defmodule UrlShortener.Link do
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key {:id, :string, []}
  schema "links" do
    field(:url, :string)

    timestamps()
  end

  @fields [:id, :url]

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> validate_url(params)
  end

  defp validate_url(changeset, %{"url" => url}) do
    if URI.parse(url).scheme == "https" do
      changeset
    else
      add_error(changeset, :url, "invalid URL")
    end
  end
end
