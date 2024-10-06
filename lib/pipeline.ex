defmodule Streaming.Pipeline do
  use Membrane.Pipeline

  @source "rtmp://127.0.0.1:1935/stream_key"

  @sink1 ""
  @sink2 ""

  @impl true
  def handle_init(_ctx, _opts) do
    structure = [
      child(:source, %Membrane.RTMP.SourceBin{
        url: @source
      }),

      child(:sink1, %Membrane.RTMP.Sink{
        rtmp_url: @sink1,
        max_attempts: :infinity,
        reset_timestamps: true
      }),

      child(:sink2, %Membrane.RTMP.Sink{
        rtmp_url: @sink2,
        max_attempts: :infinity,
        reset_timestamps: true
      }),

      get_child(:source)
      |> via_out(:audio)
      |> child(:audio_parser, %Membrane.AAC.Parser{})
      |> child(:tee_audio, Membrane.Tee.Parallel),

      get_child(:source)
      |> via_out(:video)
      |> child(:video_parser, %Membrane.H264.Parser{})
      |> child(:tee_video, Membrane.Tee.Parallel),

      get_child(:tee_audio)
      |> via_in(Pad.ref(:audio, 0))
      |> get_child(:sink1),

      get_child(:tee_video)
      |> via_in(Pad.ref(:video, 0))
      |> get_child(:sink1),

      get_child(:tee_audio)
      |> via_in(Pad.ref(:audio, 0))
      |> get_child(:sink2),

      get_child(:tee_video)
      |> via_in(Pad.ref(:video, 0))
      |> get_child(:sink2),
    ]

    {[spec: structure], %{}}
  end
end
