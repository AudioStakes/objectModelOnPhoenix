defmodule FlaskOnPhoenix.RoomChannel do
  use Phoenix.Channel
  alias FlaskOnPhoenix.Repo
  alias FlaskOnPhoenix.Sticky

  def join("rooms:lobby", auth_msg, socket) do
    {:ok, socket}
  end
  def join("rooms:" <> _private_room_id, _auth_msg, socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("sticky:create", %{"left" => x, "top" => y, "backgroundColor" => f}, socket) do
    # Stickyモデル内のレコード数をカウント
    length = Sticky
    |> Sticky.record_length
    |> FlaskOnPhoenix.Repo.all

    # 付与するＩＤを計算
    next_id = Enum.at(length, 0) + 1

    # 新規作成する付箋をStickyモデルへ追加　
    params = %{id: next_id, left: x, top: y, backgroundColor: f}
    changeset = Sticky.changeset(%Sticky{}, params)
    Repo.insert!(changeset)

    # 新規作成する付箋をクライアントへ送信
    broadcast! socket, "sticky:create", %{id: next_id, left: params.left, top: params.top, backgroundColor: params.backgroundColor}
    {:noreply, socket}
  end

  def handle_in("frame:create", %{"left" => x, "top" => y}, socket) do
    broadcast! socket, "frame:create", %{left: x, top: y}
    {:noreply, socket}
  end

  def handle_in("sticky:modified", %{
      "id" => a, "left" => b, "top" => c, "width" => d, "height" => e,
      "scaleX" => f, "scaleY" => g, "angle" => h, "group_left" => i, "group_top" => j,
      "group_width" => k, "group_height" => l, "group_scaleX" => m, "group_scaleY" => n, "group_angle" => o,
      "text" => p
    }, socket) do

    broadcast! socket, "sticky:modified", %{
      id: a, left: b, top: c, width: d, height: e,
      scaleX: f, scaleY: g, angle: h, group_left: i, group_top: j,
      group_width: k, group_height: l, group_scaleX: m, group_scaleY: n, group_angle: o,
      text: p
    }
    {:noreply, socket}
  end
end