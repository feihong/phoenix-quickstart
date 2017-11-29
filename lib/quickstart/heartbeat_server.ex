defmodule Quickstart.HeartBeatServer do
  use GenServer

  def start() do
    GenServer.cast(__MODULE__, :start)
  end

  def stop() do
    GenServer.cast(__MODULE__, :stop)
  end

  def get_active() do
    GenServer.call(__MODULE__, :active)
  end

  defmodule State do
    defstruct count: 0, active: false
  end

  def start_link() do
    GenServer.start_link(__MODULE__, %State{}, name: __MODULE__)
  end

  def handle_call(:active, _from, state) do
    {:reply, state.active, state}
  end

  def handle_cast(:start, state) do
    if not state.active do
      Process.send_after(self(), :beat, 1000)
    end
    {:noreply, %{state | active: true}}
  end
  def handle_cast(:stop, state) do
    {:noreply, %{state | active: false}}
  end

  def handle_info(:beat, state) do
    new_count = state.count + 1
    QuickstartWeb.Endpoint.broadcast! "messages", "heartbeat", %{value: new_count}
    if state.active do
      Process.send_after(self(), :beat, 1000)
    end
    {:noreply, %{state | count: new_count}}
  end
end
