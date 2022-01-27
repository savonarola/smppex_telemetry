defmodule SMPPEXTelemetry.MixProject do
  use Mix.Project

  def project do
    [
      app: :smppex_telemetry,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      source_url: "https://github.com/savonarola/smppex_telemetry",
      deps: deps(),
      description: description(),
      elixirc_paths: elixirc_paths(Mix.env()),
      docs: docs(),
      package: package()
    ]
  end

  defp description do
    "SMPP 3.4 protocol and framework implemented in Elixir"
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: [
        "README.md",
        "LICENSE"
      ]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:smppex, ">= 3.0.3"},
      {:telemetry, "~> 0.4 or ~> 1.0"},
      {:earmark, "~> 1.4", only: :dev},
      {:ex_doc, "~> 0.23", only: :dev}
    ]
  end

  defp package do
    [
      name: :smppex_telemetry,
      files: ["lib", "mix.exs", "README*", "LICENSE"],
      maintainers: ["Ilya Averyanov"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/funbox/smppex_telemetry"
      }
    ]
  end
end
