defmodule UrlShortenerWeb.LinkView do
  use UrlShortenerWeb, :view

  alias UrlShortener.Link

  def link_url(%Link{id: id}) do
    UrlShortenerWeb.Endpoint.url() <> "/#{id}"
  end

  def created_at(%Link{inserted_at: inserted_at}) do
    {:ok, time_formatted} =
      inserted_at
      |> Timex.shift(seconds: 0)
      |> Timex.format("{relative}", :relative)

    time_formatted
  end

  def get_errors(errors) when is_list(errors) do
    Enum.map(errors, fn {_key, {message, _}} -> message end)
  end

  def get_errors(_errors), do: nil
end
