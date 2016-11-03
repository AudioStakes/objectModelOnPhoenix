defmodule FlaskOnPhoenix.RoomChannel do
  use Phoenix.Channel

  def join("rooms:lobby", auth_msg, socket) do
    {:ok, socket}
  end
  def join("rooms:" <> _private_room_id, _auth_msg, socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("sticky:create", %{"left" => x, "top" => y, "json" => z}, socket) do
    # DBをupdate
    # 参考：http://www.phoenixframework.org/docs/ecto-modelsのupdate
    object = FlaskOnPhoenix.Repo.get!(FlaskOnPhoenix.Object, 1)
    changeset = FlaskOnPhoenix.Object.changeset(object, %{id: object.id, content: z})
    FlaskOnPhoenix.Repo.update(changeset)

    broadcast! socket, "sticky:create", %{left: x, top: y}
    {:noreply, socket}
  end

  def handle_in("sticky:modified", %{"id" => a, "left" => b, "top" => c, "width" => d, "height" => e, "scaleX" => f, "scaleY" => g, "angle" => h}, socket) do
    broadcast! socket, "sticky:modified", %{id: a, left: b, top: c, width: d, height: e, scaleX: f, scaleY: g, angle: h}
    {:noreply, socket}
  end
end