defmodule Viralligator.Mixfile do
  use Mix.Project

  def project do
    [app: :viralligator,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     test_coverage: [tool: ExCoveralls],
     preferred_cli_env: [coveralls: :test],
     compilers: [:thrift | Mix.compilers],
     thrift_files: Mix.Utils.extract_files(["thrift"], [:thrift]),
     docs: [ main: "Viralligator", extras: ["README.md"]],
     deps: deps()]
  end

  def application do
    [mod: {Viralligator, []},
     applications: [:logger, :httpotion, :cachex, :exredis, :riffed, :poison, :floki]]
  end

  defp deps do
    [
      {:amnesia, "~> 0.2.5"},
      {:riffed, github: "pinterest/riffed", tag: "1.0.0", submodules: true},
      {:httpotion, "~> 3.0.2"},
      {:poison, "~> 3.0"},
      {:floki, "~> 0.10.1"},
      {:exredis, ">= 0.2.4"},
      {:cachex, "~> 2.0"},
      {:decorator, "~> 1.0"}
    ]
  end
end
