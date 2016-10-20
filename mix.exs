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
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [mod: {Viralligator, []},
     applications: [:logger, :httpotion, :cachex, :edeliver, :exredis, :riffed, :poison, :floki, :mock]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:amnesia, "~> 0.2.5"},
      {:riffed, github: "pinterest/riffed", tag: "1.0.0", submodules: true},
      {:httpotion, "~> 3.0.2"},
      {:poison, "~> 3.0"},
      {:floki, "~> 0.10.1"},
      {:credo, "~> 0.4", only: [:dev, :test]},
      {:exredis, ">= 0.2.4"},
      {:cachex, "~> 2.0"},
      {:edeliver, "~> 1.4.0"},
      {:distillery, ">= 0.8.0", warn_missing: false},
      {:excoveralls, "~> 0.5", only: :test},
    ]
  end
end
