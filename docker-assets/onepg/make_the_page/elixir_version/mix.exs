defmodule OnepgEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :onepg_ex,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: escript()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :porcelain],
      mod: {OnepgEx.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:earmark, "~> 1.3.0"},
      {:porcelain, "~> 2.0"},
    ]
  end

  defp escript do
    [main_module: OnepgEx.Main]
  end
end
