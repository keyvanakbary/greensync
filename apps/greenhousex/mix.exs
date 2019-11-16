defmodule Greenhousex.MixProject do
  use Mix.Project

  def project do
    [
      app: :greenhousex,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Greenhousex.Application, []}
    ]
  end

  defp deps do
    [
      {:tesla, "~> 1.3.0"},
      {:hackney, "~> 1.15.0"},
      {:jason, "~> 1.0"},
      {:typed_struct, "~> 0.1.4"}
    ]
  end
end
