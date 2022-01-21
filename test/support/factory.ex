defmodule UrlShortener.Factory do
  @moduledoc false

  use ExMachina.Ecto, repo: UrlShortener.Repo

  alias UrlShortener.Link

  def link_factory do
    %Link{
      id: generate_random_string(6),
      url: "https://websiteffortest.com"
    }
  end

  defp generate_random_string(str_size) do
    str_size
    |> :crypto.strong_rand_bytes()
    |> Base.encode64()
    |> binary_part(0, str_size)
  end
end