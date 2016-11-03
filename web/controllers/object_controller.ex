defmodule FlaskOnPhoenix.ObjectController do
  use FlaskOnPhoenix.Web, :controller
  alias FlaskOnPhoenix.Repo
  alias FlaskOnPhoenix.Object

  @doc """
  オブジェクト一覧取得API
  """
  def index(conn, _params) do
    # すべてのオブジェクトを取得。userも一緒にロードしておく
    objects = Repo.get!(Object, 1)
    # objects = Repo.all(Object)
    render conn, :index, objects: objects
  end

  # TODO: authentication
end