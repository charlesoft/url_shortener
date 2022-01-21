defmodule UrlShortener.Links do
  @moduledoc """
  Context module to list and create links
  """
  alias UrlShortener.{Link, Repo}

  import Ecto.Query

  @str_size 6
  @limit 5

  @spec get_last_links() :: List.t()
  def get_last_links do
    query = from l in Link, order_by: [desc: l.inserted_at], limit: @limit

    Repo.all(query)
  end

  @spec create_link(map()) :: Ecto.Changeset.t()
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
