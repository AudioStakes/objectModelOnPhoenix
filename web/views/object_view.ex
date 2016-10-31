defmodule FlaskOnPhoenix.ObjectView do
  use FlaskOnPhoenix.Web, :view

  def render("index.json", %{objects: objects}) do
    # objectsの各objectを下記のobject.jsonで表示する
    %{objects: render_many(objects, FlaskOnPhoenix.objectView, "object.json")}
  end

  def render("object.json", %{object: object}) do
    # objectのid, contentをJSON形式で表示する
    %{id: object.id, body: object.content}
  end
end