# Openai

Elixir client for OpenAI.

## Installation

Adding `openai` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:openai_client, "~> 0.2"}
  ]
end
```

## Configuration

You can configure the client via `config.exs`:

```elixir
config :openai,
  api_key: "your-api-key",
  organization: "your-organization"
```

You can also specify the configuration options directly when initially a client. This will override any global config options.


```elixir
Openai.Client.new(api_key: "your-api-key", organization: "your-organization")
```
