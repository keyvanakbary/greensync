defmodule Greensync.Umbrella.MixProject do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      start_permanent: Mix.env() == :prod,
      version: "0.1.0",
      deps: deps(),
      releases: [
        greensync: [
          applications: [
            greenhousex: :permanent,
            greensync: :permanent
          ]
        ]
      ]

    ]
  end

  defp deps do
    []
  end
end
