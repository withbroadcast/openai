defmodule OpenAI.Completions do
  @moduledoc """
  Given a prompt, the model will return one or more predicted completions, and
  can also return the probabilities of alternative tokens at each position.

  https://platform.openai.com/docs/api-reference/completions
  """

  alias OpenAI.Client

  @type response_format :: %{
    required(:type) => String.t()
  }

  @type tool :: %{
    required(:type) => String.t(),
    required(:function) => tool_function()
  }

  @type tool_function :: %{
    required(:name) => String.t(),
    optional(:description) => String.t(),
    optional(:parameters) => map()
  }

  @type tool_choice :: %{
    required(:type) => String.t(),
    required(:function) => tool_function()
  }

  @type tool_choice_function :: %{
    required(:name) => String.t()
  }

  @type create_params :: %{
          required(:model) => String.t(),
          optional(:prompt) => String.t() | [String.t()],
          optional(:suffix) => String.t(),
          optional(:max_tokens) => integer(),
          optional(:temperature) => float(),
          optional(:top_p) => float(),
          optional(:n) => integer(),
          optional(:stream) => boolean(),
          optional(:logprobs) => integer(),
          optional(:echo) => boolean(),
          optional(:stop) => String.t() | [String.t()],
          optional(:presence_penalty) => float(),
          optional(:frequency_penalty) => float(),
          optional(:best_of) => integer(),
          optional(:logit_bias) => %{String.t() => float()},
          optional(:response_format) => response_format(),
          optional(:tools) => [tool()],
          optional(:tool_choice) => String.t() | tool_choice(),
          optional(:user) => String.t()
        }

  @doc """
  Creates a completion for the provided prompt and parameters
  """
  @spec create(Client.t(), create_params(), Keyword.t()) :: Client.result()
  def create(client, params, opts \\ []) do
    opts = Client.with_stream_opts(params, opts)

    client
    |> Client.post("/v1/completions", params, opts)
    |> Client.handle_response(opts)
  end
end
