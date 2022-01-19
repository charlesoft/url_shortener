defmodule UrlShortener.Repo.Migrations.ModifyUrlToTextOnLinksTable do
  use Ecto.Migration

  def change do
    alter table(:links) do
      modify :url, :text
    end
  end
end
