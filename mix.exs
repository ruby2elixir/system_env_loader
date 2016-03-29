defmodule SystemEnvLoader.Mixfile do
  use Mix.Project

  @version "0.1.0"

  def project do
    [app: :system_env_loader,
     version: @version,
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     package: package,
     docs: [extras: ["README.md"]],
     deps: deps]
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
  # To depend on another app inside the umbrella:
  #
  #   {:myapp, in_umbrella: true}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    []
  end


  defp package do
    [
     maintainers: ["Roman Heinrich"],
     licenses: ["MIT License"],
     description: "A little package to load (bashlike) files with exported ENV variables into Elixir runtime",
     links: %{
       github: "https://github.com/ruby2elixir/system_env_loader",
       docs: "http://hexdocs.pm/system_env_loader/#{@version}/"
     }
    ]
  end
end
