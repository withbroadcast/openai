defmodule OpenAI.MixProject do
  use Mix.Project

  @version "0.5.2"
  @url "https://github.com/withbroadcast/openai"

  def project do
    [
      app: :openai_client,
      version: @version,
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      description: "Elixir client for OpenAI API",
      deps: deps(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp package do
    [
      name: "openai_client",
      maintainers: ["Connor Jacobsen"],
      licenses: ["MIT"],
      links: %{"GitHub" => @url, "Source" => @url}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.27", only: :dev, runtime: false},
      {:bypass, "~> 2.1", only: :test},
      {:castore, "~> 1.0"},
      {:jason, "~> 1.4"},
      {:mint, "~> 1.5"},
      {:plug, "~> 1.14", only: :test},
      {:tesla, "~> 1.6"}
    ]
  end
end
