defmodule ShortUUID do
  @moduledoc """
  ShortUUID allows UUIDs to be encoded in a more URL- and user-friendly Base58 format:

      iex> ShortUUID.encode("64d7280f-736a-4ffa-b9c0-383f43486d0b")
      "DTEETeS5R2XxjrVTZxXoJS"

      iex> ShortUUID.decode("DTEETeS5R2XxjrVTZxXoJS")
      "64d7280f-736a-4ffa-b9c0-383f43486d0b"

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
      "DTEETeS5R2XxjrVTZxXoJS"

  """
  @spec encode(String.t()) :: String.t()
  def encode(input) when is_binary(input) do
    input
    |> String.replace("-", "")
    |> String.to_integer(16)
    |> encode("")
  end

  defp encode(input, output) when input > 0 do
    index = rem(input, @abc_length)
    input = div(input, @abc_length)
    output = "#{Enum.at(@abc, index)}#{output}"

    encode(input, output)
  end

  defp encode(0, output), do: output

  @doc """
  Decodes the given ShortUUID back into a UUID.

  ## Examples

      iex> ShortUUID.decode("DTEETeS5R2XxjrVTZxXoJS")
      "64d7280f-736a-4ffa-b9c0-383f43486d0b"

  """
  @spec decode(String.t()) :: String.t()
  def decode(input) when is_binary(input) do
    input
    |> String.codepoints()
    |> Enum.reduce(0, fn codepoint, acc ->
      acc * @abc_length + Enum.find_index(@abc, &(&1 == codepoint))
    end)
    |> Integer.to_string(16)
    |> String.pad_leading(32, "0")
    |> String.downcase()
    |> format()
  end

  defp format(<<a::64, b::32, c::32, d::32, e::96>>) do
    <<a::64, ?-, b::32, ?-, c::32, ?-, d::32, ?-, e::96>>
  end
end
