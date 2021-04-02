# ShortUUID

<!-- MDOC !-->

ShortUUID allows UUIDs to be encoded in [a more URL- and user-friendly Base58
format](https://github.com/bitcoin/bitcoin/blob/08a7316c144f9f2516db8fa62400893f4358c5ae/src/base58.h#L6-L13):

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
