defmodule ShortUUID.MixProject do
  use Mix.Project

  def project do
    [
      app: :short_uuid,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),

      # Docs
      name: "ShortUUID",
      source_url: "https://github.com/YodelTalk/short_uuid"
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
      maintainers: ["Mario Uher"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/YodelTalk/short_uuid"}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.22", only: :dev, runtime: false},
      {:stream_data, "~> 0.1", only: :test}
    ]
  end
end
