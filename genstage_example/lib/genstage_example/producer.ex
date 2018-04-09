# Producer

defmodule GenstageExample.Producer do
  use GenStage

  def start_link(initial \\ 0) do
    GenStage.start_link(__MODULE__, initial, name: __MODULE__)
  end

  # Label ourselves as a producer as init/1 function is what GenStage
  # relies upon to classify our process.

  def init(counter), do: {:producer, counter}

  # Return the set of numbers demanded by our customers and increment our counter
  def handle_demand(demand, state) do
    events = Enum.to_list(state..(state + demand - 1))
    {:noreply, events, state + demand}
  end
end
