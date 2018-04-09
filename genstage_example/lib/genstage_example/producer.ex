# Producer

defmodule GenstageExample.Producer do
  use GenStage

  def start_link(initial \\ 0) do
    GenStage.start_link(__MODULE__, initial, name: __MODULE__)
  end

  # Label ourselves as a producer as init/1 function is what GenStage
  # relies upon to classify our process.

  def init(counter), do: {:producer, counter}

  # Return the set of numbers demanded by our customers and increment our counter.
  # If the counter is 3 and demand is for 2 items, we will
  # emit items 3 and 4 and set the state to 5.
  def handle_demand(demand, counter) do
    events = Enum.to_list(counter..(counter + demand - 1))
    {:noreply, events, counter + demand}
  end
end
