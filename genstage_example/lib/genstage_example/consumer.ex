# Consumer

defmodule GenstageExample.Consumer do
  use GenStage

  def start_link do
    GenStage.start_link(__MODULE__, :state_doesnt_matter)
  end

  # subscribe_to option instructs GenStage to put us in communication with specific producer_consumer
  def init(state) do
    {:consumer, state, subscribe_to: [GenstageExample.ProducerConsumer]}
  end

  # Receives incoming events, processes them and returns transformed set.
  # Consumer does not emit events so second value in tuple returned is discarded
  def handle_events(events, _from, state) do
    for event <- events do
      IO.inspect({self(), event, state})
    end

    {:noreply, [], state}
  end
end
