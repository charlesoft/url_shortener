defmodule UrlShortener.Links do

  alias UrlShortener.{Link, Repo}

  @str_size 6

  def create_link(attributes) do
    attributes = Map.put(attributes, "id", generate_random_string())

    %Link{}
    |> Link.changeset(attributes)
    |> Repo.insert()
  end

  defp generate_random_string do
    @str_size
    |> :crypto.strong_rand_bytes()
    |> Base.encode64()
    |> binary_part(0, @str_size)
  end
end