defmodule Viralligator.Mixfile do
  use Mix.Project

  def project do
    [app: :viralligator,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     compilers: [:thrift | Mix.compilers],
     thrift_files: Mix.Utils.extract_files(["thrift"], [:thrift]),
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
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
      {:riffed, github: "pinterest/riffed", tag: "1.0.0", submodules: true},
      {:credo, "~> 0.4", only: [:dev, :test]}
    ]
  end
end
