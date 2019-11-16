defmodule Greensync.MixProject do
  use Mix.Project

  def project do
    [
      app: :greensync,
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
      mod: {Greensync.Application, []}
    ]
  end

  defp deps do
    [
      {:greenhousex, in_umbrella: true},
      {:quantum, "~> 2.3"},
      {:timex, "~> 3.0"},
      {:ecto_sql, "~> 3.0"},
      {:myxql, "~> 0.2.0"}
    ]
  end
end
