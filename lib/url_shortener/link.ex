defmodule UrlShortener.Link do
  @moduledoc """
  Module to handle Link Struct
  """
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key {:id, :string, []}
  schema "links" do
    field(:url, :string)

    timestamps()
  end

  @fields [:id, :url]

  @spec changeset(map(), map()) :: Ecto.Changeset.t()
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> validate_url(params)
  end

  defp validate_url(changeset, %{"url" => url}) do
    parsed_url = URI.parse(url)

    if parsed_url.scheme == "https" or parsed_url.scheme == "http" do
      changeset
    else
      add_error(changeset, :url, "invalid URL")
    end
  end

  defp validate_url(changeset, _params), do: changeset
end
