# ShortUUID

ShortUUID ([docs](https://hexdocs.pm/short_uuid)) allows UUIDs to be encoded in a more URL- and user-friendly Base58
format:

```elixir
ShortUUID.encode("64d7280f-736a-4ffa-b9c0-383f43486d0b")
# "DTEETeS5R2XxjrVTZxXoJS"

ShortUUID.decode("DTEETeS5R2XxjrVTZxXoJS")
# "64d7280f-736a-4ffa-b9c0-383f43486d0b"
```

## Installation

Add `short_uuid` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:short_uuid, "~> 1.0.0"}
  ]
end
```

## License

MIT
