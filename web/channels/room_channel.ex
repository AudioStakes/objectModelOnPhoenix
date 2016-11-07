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

    reduce_string = ~s("id":)
    reduce_string_length = reduce_string
    |> String.length

    content = FlaskOnPhoenix.Object
    |> FlaskOnPhoenix.Object.id1
    |> FlaskOnPhoenix.Repo.all
    |> to_string

    content_length = content
    |> String.length

    content_length_reduced = content
    |> String.replace(reduce_string, "")
    |> String.length

    reduced_length = content_length - content_length_reduced
    next_id_number = reduced_length/reduce_string_length

    broadcast! socket, "sticky:create", %{left: x, top: y, id: next_id_number}
    {:noreply, socket}
  end

  def handle_in("sticky:modified", %{"id" => a, "left" => b, "top" => c, "width" => d, "height" => e, "scaleX" => f, "scaleY" => g, "angle" => h}, socket) do
    broadcast! socket, "sticky:modified", %{id: a, left: b, top: c, width: d, height: e, scaleX: f, scaleY: g, angle: h}
    {:noreply, socket}
  end

  def count(sentence) do
    sentence
    |> String.split
    |> count
  end
end