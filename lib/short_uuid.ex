defmodule ShortUUID do
  @moduledoc """
  ShortUUID allows UUIDs to be encoded in a more URL- and user-friendly Base58 format:

      iex> ShortUUID.encode("64d7280f-736a-4ffa-b9c0-383f43486d0b")
      {:ok, "DTEETeS5R2XxjrVTZxXoJS"}

      iex> ShortUUID.decode("DTEETeS5R2XxjrVTZxXoJS")
      {:ok, "64d7280f-736a-4ffa-b9c0-383f43486d0b"}

  """

  @abc ["1", "2", "3", "4", "5", "6", "7", "8", "9"] ++
         ["A", "B", "C", "D", "E", "F", "G", "H"] ++
         ["J", "K", "L", "M", "N"] ++
         ["P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"] ++
         ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k"] ++
         ["m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]

  @abc_length Enum.count(@abc)

  @doc """
  Encodes the given UUID into a ShortUUID.

  ## Examples

      iex> ShortUUID.encode("64d7280f-736a-4ffa-b9c0-383f43486d0b")
      {:ok, "DTEETeS5R2XxjrVTZxXoJS"}

      iex> ShortUUID.encode("invalid-uuid-here")
      {:error, :invalid_uuid}

  """
  @spec encode(String.t()) :: {:ok, String.t()} | {:error, :invalid_uuid}
  def encode(input) when is_binary(input) do
    case input do
      <<_a::64, ?-, _b::32, ?-, _c::32, ?-, _d::32, ?-, _e::96>> ->
        input
        |> String.replace("-", "")
        |> String.to_integer(16)
        |> encode("")

      _ ->
        {:error, :invalid_uuid}
    end
  end

  defp encode(input, output) when input > 0 do
    index = rem(input, @abc_length)
    input = div(input, @abc_length)
    output = "#{Enum.at(@abc, index)}#{output}"

    encode(input, output)
  end

  defp encode(0, output), do: {:ok, output}

  @doc """
  Decodes the given ShortUUID back into a UUID.

  ## Examples

      iex> ShortUUID.decode("DTEETeS5R2XxjrVTZxXoJS")
      {:ok, "64d7280f-736a-4ffa-b9c0-383f43486d0b"}

      iex> ShortUUID.decode("DTEETeS5R2XxjrVTZxXoJS123")
      {:error, :invalid_uuid}

      iex> ShortUUID.decode("InvalidShortUUID")
      {:error, :invalid_uuid}

  """
  @spec decode(String.t()) :: {:ok, String.t()} | {:error, :invalid_uuid}
  def decode(input) when is_binary(input) do
    codepoints = String.codepoints(input)

    unless Enum.all?(codepoints, &(&1 in @abc)) do
      {:error, :invalid_uuid}
    else
      codepoints
      |> Enum.reduce(0, fn codepoint, acc ->
        acc * @abc_length + Enum.find_index(@abc, &(&1 == codepoint))
      end)
      |> Integer.to_string(16)
      |> String.pad_leading(32, "0")
      |> String.downcase()
      |> format()
    end
  end

  defp format(<<a::64, b::32, c::32, d::32, e::96>>) do
    {:ok, <<a::64, ?-, b::32, ?-, c::32, ?-, d::32, ?-, e::96>>}
  end

  defp format(_) do
    {:error, :invalid_uuid}
  end
end
