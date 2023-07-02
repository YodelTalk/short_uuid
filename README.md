# ShortUUID

<!-- MDOC !-->

An Elixir module for handling ShortUUIDs.

This module provides functions to encode and decode between regular UUIDs and ShortUUIDs.

It can be especially useful when you want to use UUIDs, but you need them to be shorter.
For example, you can use ShortUUIDs in URL shorteners or for a more user-friendly representation of UUIDs.

Inspired by [bitcoin](https://github.com/bitcoin/bitcoin/blob/08a7316c144f9f2516db8fa62400893f4358c5ae/src/base58.h#L6-L13).

## Examples

```elixir
iex> ShortUUID.encode("64d7280f-736a-4ffa-b9c0-383f43486d0b")
{:ok, "DTEETeS5R2XxjrVTZxXoJS"}

iex> ShortUUID.decode("DTEETeS5R2XxjrVTZxXoJS")
{:ok, "64d7280f-736a-4ffa-b9c0-383f43486d0b"}
```

<!-- MDOC !-->

## Installation

Add `short_uuid` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:short_uuid, "~> 2.1.0"}
  ]
end
```

## License

[MIT](./LICENSE)
