defmodule ShortUUIDTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  doctest ShortUUID

  @abc Enum.concat([?0..?9, ?a..?f])

  test "encode/1" do
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
      assert uuid == ShortUUID.decode!(ShortUUID.encode!(uuid))
    end
  end

  test "encode!/1 raises on error" do
    assert_raise ArgumentError, fn ->
      ShortUUID.encode!("invalid-uuid-here")
    end
  end

  test "decode!/1 raises on error" do
    assert_raise ArgumentError, fn ->
      ShortUUID.decode!("DTEETeS5R2XxjrVTZxXoJS123")
    end

    assert_raise ArgumentError, fn ->
      ShortUUID.decode!("InvalidShortUUID")
    end
  end
end
