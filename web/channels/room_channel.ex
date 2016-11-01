defmodule FlaskOnPhoenix.RoomChannel do
  use Phoenix.Channel

  def join("rooms:lobby", auth_msg, socket) do
    {:ok, socket}
  end
  def join("rooms:" <> _private_room_id, _auth_msg, socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("sticky:create", %{"left" => x, "top" => y, "json" => z}, socket) do
    # オブジェクトを作成
    # user = Repo.get(User, socket.assigns[:user_id]) |> Repo.preload(:messages)
    # object = Ecto.Model.build(object, :objects, content: object["body"])
    # changeset = Object.changeset(%Object{}, z)
    changeset = %FlaskOnPhoenix.Object{content: "z"}  
    FlaskOnPhoenix.Repo.insert!(changeset)   

    # iex(1)> post = %EctoBlog.Post{title: "Hello", content: "Ecto"}     
    # iex(2)> {:ok, inserted_post} = EctoBlog.Repo.insert(post)     

    broadcast! socket, "sticky:create", %{left: x, top: y}
    {:noreply, socket}
  end

  def handle_in("sticky:modified", %{"id" => a, "left" => b, "top" => c, "width" => d, "height" => e, "scaleX" => f, "scaleY" => g, "angle" => h}, socket) do
    broadcast! socket, "sticky:modified", %{id: a, left: b, top: c, width: d, height: e, scaleX: f, scaleY: g, angle: h}
    {:noreply, socket}
  end
end