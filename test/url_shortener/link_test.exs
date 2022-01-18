defmodule UrlShortener.LinkTest do
  use UrlShortener.DataCase

  alias UrlShortener.Link

  test "creates a valid changeset" do
    id = :crypto.strong_rand_bytes(6) |> Base.encode64()
    params = %{"id" => id, "url" => "https://trucks.com"}

    changeset = Link.changeset(%Link{}, params)

    assert changeset.valid?
  end

  test "creates an invalid changeset with invalid url" do
    id = :crypto.strong_rand_bytes(6) |> Base.encode64()
    params = %{"id" => id, "url" => "invalid_url.com"}

    changeset = Link.changeset(%Link{}, params)

    assert %{url: ["invalid URL"]} = errors_on(changeset)
  end

  test "creates an invalid changeset with invalid id" do
    id = 1
    params = %{"id" => id, "url" => "https://trucks.com"}

    changeset = Link.changeset(%Link{}, params)

    assert %{id: ["is invalid"]} = errors_on(changeset)
  end
end
