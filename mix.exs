defmodule Greenhousex.MixProject do
  use Mix.Project

  def project do
    [
      app: :greensync,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Greensync.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:tesla, "~> 1.3.0"},
      {:jason, "~> 1.0"},
      {:typed_struct, "~> 0.1.4"},
      {:quantum, "~> 2.3"},
      {:timex, "~> 3.0"},
      {:ecto_sql, "~> 3.0"},
      {:myxql, "~> 0.2.0"}
    ]
  end
end
