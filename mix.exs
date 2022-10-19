defmodule ExFontawesomePro.MixProject do
  use Mix.Project

  @version "0.0.1"

  def project do
    [
      app: :ex_fontawesome_pro,
      version: @version,
      elixir: "~> 1.11",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      description: description(),
      package: package(),
      source_url: "https://github.com/carldr/ex_fontawesome_pro"
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:phoenix_html, "~> 3.2"},
      {:ex_doc, "~> 0.27", only: :dev, runtime: false},
      {:floki, ">= 0.32.0", only: :test},
      {:phoenix_live_view, "~> 0.18", optional: true},
      {:surface, "~> 0.7", optional: true}
    ]
  end

  defp docs do
    [
      main: "FontAwesome Pro",
      source_ref: "v#{@version}",
      source_url: "https://github.com/carldr/ex_fontawesome_pro",
      groups_for_modules: [
        Liveview: ~r/FontAwesomePro.LiveView/,
        Surface: ~r/FontAwesomePro.Surface/
      ],
      nest_modules_by_prefix: [
        FontAwesomePro.LiveView,
        FontAwesomePro.Surface
      ],
      extras: ["README.md"]
    ]
  end

  defp description() do
    """
    This package adds a convenient way of using Font Awesome Pro SVGs with your Phoenix, Phoenix LiveView and Surface applications.
    """
  end

  defp package do
    %{
      files: ~w(lib node_modules .formatter.exs mix.exs README* LICENSE* CHANGELOG*),
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/carldr/ex_fontawesome_pro"}
    }
  end
end
