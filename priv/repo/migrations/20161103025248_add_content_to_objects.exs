defmodule FlaskOnPhoenix.Repo.Migrations.AddContentToObjects do
  use Ecto.Migration

  def change do
    alter table(:objects) do
      add :content, :text
    end
  end
end
