defmodule QuickstartWeb.MessageChannel do
  use Phoenix.Channel

  def join("messages", _message, socket) do
    {:ok, socket}
  end
  def join(_topic, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("heartbeat", "start", socket) do
    Quickstart.HeartBeatServer.start()
    {:noreply, socket}
  end
  def handle_in("heartbeat", "stop", socket) do
    Quickstart.HeartBeatServer.stop()
    {:noreply, socket}
  end
  def handle_in("do_stuff", _payload, socket) do
    # Do this stuff asynchronously, or you'll block processing of other channel
    # messages.
    Task.async(fn -> do_stuff socket end)
    {:noreply, socket}
  end
  def handle_in(mesg_name, payload, socket) do
    IO.puts "Got message #{mesg_name}: #{inspect payload}"
    {:noreply, socket}
  end

  defp do_stuff(socket) do
    task_id =
      [
        Enum.random(?a..?z),
        Enum.random(?0..?9),
        Enum.random(?a..?z),
      ]
      |> to_string()

    max = Enum.random(6..12)
    for n <- 1..max do
      broadcast! socket, "task_progress", %{task_id: task_id, value: n}
      Process.sleep 300
    end
    broadcast! socket, "task_result", %{task_id: task_id, value: "Yay we are finished"}
  end
end
