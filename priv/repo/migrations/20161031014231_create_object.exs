defmodule FlaskOnPhoenix.Repo.Migrations.CreateObject do
  use Ecto.Migration

  def change do
    create table(:objects) do
      add :content, :string

      timestamps()
    end

  end
end
