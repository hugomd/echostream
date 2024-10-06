defmodule Streaming.MixProject do
  use Mix.Project

  def project do
    [
      app: :streaming,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:membrane_core, "~> 1.1.1"},
      {:membrane_rtmp_plugin, "~> 0.26"},
      {:membrane_h264_plugin, "~> 0.9.3"},
      {:membrane_flv_plugin, "~> 0.12.0"},
      {:membrane_tee_plugin, "~> 0.12.0"},
    ]
  end
end
