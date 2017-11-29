defmodule QuickstartWeb.MessageChannel do
  use Phoenix.Channel

  def join("message:general", _message, socket) do
    {:ok, socket}
  end
  def join("room:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("heartbeat", "start", socket) do
    broadcast! socket, "heartbeat", %{value: 101}
    {:noreply, socket}
  end
  def handle_in("do_stuff", _payload, socket) do
    do_stuff socket
    {:noreply, socket}
  end
  def handle_in(mesg_name, payload, socket) do
    IO.puts "Got message #{mesg_name}: #{inspect payload}"
    {:noreply, socket}
  end

  defp do_stuff(socket) do
    max = Enum.random(3..10)
    for n <- 1..max do
      broadcast! socket, "useful_result", %{value: n}
      Process.sleep 300
    end
  end
end
