defmodule FlaskOnPhoenix.Object do
  use FlaskOnPhoenix.Web, :model

  schema "objects" do
    field :content, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:content])
    |> validate_required([:content])
  end

  def id1(query) do
    from o in query,
    where: o.id == 1,
    select: o.content
  end

end
