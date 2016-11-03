defmodule SignUp.Mixfile do
  use Mix.Project

  def project do
    [app: :sign_up,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [applications: [:logger, :cowboy, :plug],
     mod: {SignUp, []}]
  end

  defp deps do
    [{:cowboy, "~> 1.0.4"},
     {:plug, "~> 1.0"},
     {:poison, "~> 2.0"},
     {:credo, "~> 0.4", only: [:dev, :test]}]
  end
end
