defmodule ShortUUID.Guards do
  @doc """
  Checks if the input is a valid UUID string.
  """
  defguard is_uuid(value)
           when is_binary(value) and
                  byte_size(value) == 36 and
                  binary_part(value, 8, 1) == "-" and
                  binary_part(value, 13, 1) == "-" and
                  binary_part(value, 18, 1) == "-" and
                  binary_part(value, 23, 1) == "-"
end
