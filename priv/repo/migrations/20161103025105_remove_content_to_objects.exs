defmodule FlaskOnPhoenix.Repo.Migrations.RemoveContentToObjects do
  use Ecto.Migration

  def change do
    alter table(:objects) do
      remove :content
    end
  end
end