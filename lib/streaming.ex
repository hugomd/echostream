defmodule Streaming do
  import Streaming.Pipeline

  def start do
    Membrane.Pipeline.start_link(Streaming.Pipeline)
  end
end
