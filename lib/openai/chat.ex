defmodule OpenAI.Chat do
  @moduledoc """
  Given a chat conversation, the model will return a chat completion response.

  https://platform.openai.com/docs/api-reference/chat
  """

  alias OpenAI.Client

  @type message :: %{
    required(:role) => String.t(),
    required(:content) => String.t()
  }

  @type create_completion_params :: %{
    required(:model) => String.t(),
    required(:messages) => [message()],
    optional(:temperature) => float(),
    optional(:top_p) => float(),
    optional(:n) => integer(),
    optional(:stream) => boolean(),
    optional(:stop) => String.t() | [String.t()],
    optional(:max_tokens) => integer(),
    optional(:presence_penalty) => float(),
    optional(:frequency_penalty) => float(),
    optional(:logit_bias) => %{String.t() => float()},
    optional(:user) => String.t()
  }

  @doc """
  Creates a completion for the chat message
  """
  @spec create_completion(Client.t(), create_completion_params(), Keyword.t()) :: Client.result()
  def create_completion(client, params, opts \\ []) do
    # TODO: handle streaming responses!

    client
    |> Client.post("/v1/chat/completions", params, opts)
    |> Client.handle_response(opts)
  end
end
