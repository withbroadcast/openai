defmodule OpenAI.Moderations do
  @moduledoc """
  Given a input text, outputs if the model classifies it as violating OpenAI's content policy.

  Related guide: [Moderations](https://platform.openai.com/docs/guides/moderation)

  https://platform.openai.com/docs/api-reference/moderations
  """

  alias OpenAI.Client

  @type create_params :: %{
    required(:input) => String.t() | [String.t()],
    optional(:model) => String.t()
  }

  @doc """
  Classifies if text violates OpenAI's Content Policy
  """
  @spec create(Client.t(), create_params(), Keyword.t()) :: Client.result()
  def create(client, params, opts \\ []) do
    client
    |> Client.post("/v1/moderations", params, opts)
    |> Client.handle_response(opts)
  end
end
