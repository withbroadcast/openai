defmodule OpenAI.Completions do
  @moduledoc """
  Given a prompt, the model will return one or more predicted completions, and
  can also return the probabilities of alternative tokens at each position.

  https://platform.openai.com/docs/api-reference/completions
  """

  alias OpenAI.Client

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
          optional(:user) => String.t()
        }

  @doc """
  Creates a completion for the provided prompt and parameters
  """
  @spec create(Client.t(), create_params(), Keyword.t()) :: Client.result()
  def create(client, params, opts \\ []) do
    # TODO: handle streaming responses!

    client
    |> Client.post("/v1/completions", params, opts)
    |> Client.handle_response(opts)
  end
end
