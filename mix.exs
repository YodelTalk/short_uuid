defmodule ShortUUID.MixProject do
  use Mix.Project

  @version "2.0.0"
  @url "https://github.com/YodelTalk/short_uuid"
  @maintainers ["Mario Uher"]

  def project do
    [
      app: :short_uuid,
      version: @version,
      elixir: ">= 1.5.3",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),

      # Docs
      name: "ShortUUID",
      source_url: @url,
      docs: [main: "ShortUUID"]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    []
  end

  defp description do
    """
    ShortUUID allows UUIDs to be encoded in a more URL- and user-friendly Base58 format.
    """
  end

  defp package do
    [
      maintainers: @maintainers,
      licenses: ["MIT"],
      links: %{"GitHub" => @url}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.23.0", only: :dev, runtime: false},
      {:stream_data, "~> 0.5.0", only: :test}
    ]
  end
end
