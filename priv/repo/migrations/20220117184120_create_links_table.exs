defmodule UrlShortener.Repo.Migrations.CreateLinksTable do
  use Ecto.Migration

  def change do
    create table(:links, primary_key: false) do
      add :id, :string, size: 6, primary_key: true
      add :url, :string, null: false

      timestamps()
    end
  end
end
