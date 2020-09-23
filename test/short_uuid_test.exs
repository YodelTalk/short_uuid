defmodule ShortUUIDTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  doctest ShortUUID

  @abc Enum.concat([?0..?9, ?a..?f])

  test "encode" do
    uuid_generator = [
      StreamData.string(@abc, length: 8),
      StreamData.constant("-"),
      StreamData.string(@abc, length: 4),
      StreamData.constant("-"),
      StreamData.string(@abc, length: 4),
      StreamData.constant("-"),
      StreamData.string(@abc, length: 4),
      StreamData.constant("-"),
      StreamData.string(@abc, length: 12)
    ]

    check all(uuid <- StreamData.map(StreamData.fixed_list(uuid_generator), &Enum.join/1)) do
      assert uuid == ShortUUID.decode(ShortUUID.encode(uuid))
    end
  end
end
