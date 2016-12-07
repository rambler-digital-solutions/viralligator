defmodule Viralligator.Mixfile do
  use Mix.Project

  def project do
    [app: :viralligator,
     version: "1.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     preferred_cli_env: [coveralls: :test],
     compilers: [:thrift | Mix.compilers],
     thrift_files: Mix.Utils.extract_files(["thrift"], [:thrift]),
     docs: [ main: "Viralligator", extras: ["README.md"]],
     description: description(),
     package: package(),
     deps: deps()]
  end

  def application do
    [mod: {Viralligator, []},
     applications: [:logger, :httpotion, :cachex, :exredis, :riffed, :poison, :floki]]
  end

  defp description do
   """
    Viralligator
   """
  end

  defp package do
    [
      name: :viralligator,
      files: ["lib", "thrift", "mix.exs", "config", "VERSION", "README*"],
      maintainers: ["a.antonov@rambler-co.ru", "artem.malyshev@rambler-co.ru",
      "d.zuev@rambler-co.ru", "a.matrynyuk@rambler-co.ru", "stass.german@rambler-co.ru"],
      licenses: [],
      links: []
    ]
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
      {:decorator, "~> 1.0"},
    ]
  end
end
