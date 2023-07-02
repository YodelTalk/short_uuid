defmodule ShortUUID do
  import ShortUUID.Guards

  @external_resource "README.md"

  @moduledoc "README.md"
             |> File.read!()
             |> String.split("<!-- MDOC !-->")
             |> Enum.fetch!(1)

  @abc ["1", "2", "3", "4", "5", "6", "7", "8", "9"] ++
         ["A", "B", "C", "D", "E", "F", "G", "H"] ++
         ["J", "K", "L", "M", "N"] ++
         ["P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"] ++
         ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k"] ++
         ["m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]

  @abc_length Enum.count(@abc)

  @typedoc """
  A UUID (Universally Unique Identifier) is a 128-bit number used to uniquely identify
  some object or entity on the internet. In its canonical form, a UUID is represented
  by 32 lowercase hexadecimal digits, displayed in five groups separated by hyphens,
  in the form 8-4-4-4-12 for a total of 36 characters (32 alphanumeric characters and 4 hyphens).
  """
  @type uuid :: binary()

  @typedoc """
  A short UUID is a more compact string representation of a UUID. It encodes the
  exact same information but uses a larger character set. This results in a shorter
  string for the same information.
  """
  @type short_uuid :: binary()

  @doc """
  Encodes the given UUID into a ShortUUID.

  The function returns a tuple `{:ok, short_uuid}` if encoding is successful. In
  case of invalid input UUID, the function returns `{:error, :invalid_uuid}`.

  ## Examples

      iex> ShortUUID.encode("64d7280f-736a-4ffa-b9c0-383f43486d0b")
      {:ok, "DTEETeS5R2XxjrVTZxXoJS"}

      iex> ShortUUID.encode("invalid-uuid-here")
      {:error, :invalid_uuid}

  """
  @spec encode(uuid()) :: {:ok, short_uuid()} | {:error, :invalid_uuid}
  def encode(input) when is_uuid(input) do
    input
    |> String.replace("-", "")
    |> String.to_integer(16)
    |> encode("")
  end

  def encode(_), do: {:error, :invalid_uuid}

  defp encode(input, output) when input > 0 do
    index = rem(input, @abc_length)
    input = div(input, @abc_length)
    output = "#{Enum.at(@abc, index)}#{output}"

    encode(input, output)
  end

  defp encode(0, output), do: {:ok, output}

  @doc """
  Encodes the given UUID into a ShortUUID.

  This function works similarly to `encode/1`, but instead of returning an error
  tuple, it raises `ArgumentError` in case of an invalid UUID.

  ## Examples

      iex> ShortUUID.encode!("64d7280f-736a-4ffa-b9c0-383f43486d0b")
      "DTEETeS5R2XxjrVTZxXoJS"

  """
  @doc since: "2.1.0"
  @spec encode!(uuid()) :: short_uuid()
  def encode!(input) do
    case encode(input) do
      {:ok, result} -> result
      {:error, _error} -> raise ArgumentError
    end
  end

  @doc """
  Decodes the given ShortUUID back into a UUID.

  The function returns a tuple `{:ok, uuid}` if decoding is successful. In case
  of invalid input ShortUUID, the function returns `{:error, :invalid_uuid}`.

  ## Examples

      iex> ShortUUID.decode("DTEETeS5R2XxjrVTZxXoJS")
      {:ok, "64d7280f-736a-4ffa-b9c0-383f43486d0b"}

      iex> ShortUUID.decode("DTEETeS5R2XxjrVTZxXoJS123")
      {:error, :invalid_uuid}

      iex> ShortUUID.decode("InvalidShortUUID")
      {:error, :invalid_uuid}

  """
  @spec decode(short_uuid()) :: {:ok, uuid()} | {:error, :invalid_uuid}
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

  @doc """
  Decodes the given ShortUUID back into a UUID.

  This function works similarly to `decode/1`, but instead of returning an error
  tuple, it raises `ArgumentError` in case of an invalid ShortUUID.

  ## Examples

      iex> ShortUUID.decode!("DTEETeS5R2XxjrVTZxXoJS")
      "64d7280f-736a-4ffa-b9c0-383f43486d0b"

  """
  @doc since: "2.1.0"
  @spec decode!(short_uuid()) :: uuid()
  def decode!(input) do
    case decode(input) do
      {:ok, result} -> result
      {:error, _} -> raise ArgumentError
    end
  end

  defp format(<<a::64, b::32, c::32, d::32, e::96>>) do
    {:ok, <<a::64, ?-, b::32, ?-, c::32, ?-, d::32, ?-, e::96>>}
  end

  defp format(_) do
    {:error, :invalid_uuid}
  end
end
