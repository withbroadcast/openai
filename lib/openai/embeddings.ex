defmodule OpenAI.Embeddings do
  @moduledoc """
  Get a vector representation of a given input that can be easily consumed by machine learning models and algorithms.

  Related guide: [Embeddings](https://platform.openai.com/docs/guides/embeddings)

  https://platform.openai.com/docs/api-reference/embeddings
  """

  alias OpenAI.Client

  @type create_params :: %{
          required(:model) => String.t(),
          required(:input) => String.t() | [String.t()],
          optional(:user) => String.t()
        }

  @doc """
  Creates an embedding vector representing the input text.
  """
  @spec create(Client.t(), create_params(), Keyword.t()) :: Client.result()
  def create(client, params, opts \\ []) do
    client
    |> Client.post("/v1/embeddings", params, opts)
    |> Client.handle_response(opts)
  end
end
