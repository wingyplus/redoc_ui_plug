defmodule Redoc.MixProject do
  use Mix.Project

  def project do
    [
      app: :redoc_ui_plug,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "Redoc",
      source_url: "https://github.com/wingyplus/redoc_ui_plug",
      package: package(),
      description: description()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:plug, "~> 1.0"},
      {:ex_doc, "~> 0.28", only: :dev, runtime: false},
      {:open_api_spex, "~> 3.10"},
      {:jason, "~> 1.0"}
    ]
  end

  defp description do
    "The Elixir package to render Redoc UI from OpenAPI specification."
  end

  defp package do
    [
      name: "redoc_ui_plug",
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/wingyplus/redoc_ui_plug"}
    ]
  end
end
