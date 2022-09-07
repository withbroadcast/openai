defmodule OpenAI.Edits do
  @moduledoc """
  Given a prompt and an instruction, the model will return an edited version of the prompt.

  https://platform.openai.com/docs/api-reference/edits
  """

  alias OpenAI.Client

  @type create_params :: %{
    required(:model) => String.t(),
    optional(:input) => String.t(),
    required(:instruction) => String.t(),
    optional(:n) => integer(),
    optional(:temperature) => float(),
    optional(:top_p) => float()
  }

  @doc """
  Creates a new edit for the provided input, instruction, and parameters.
  """
  @spec create(Client.t(), create_params(), Keyword.t()) :: Client.result()
  def create(client, params, opts \\ []) do
    client
    |> Client.post("/v1/edits", params, opts)
    |> Client.handle_response(opts)
  end
end
