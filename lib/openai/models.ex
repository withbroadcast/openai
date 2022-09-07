defmodule OpenAI.Models do
  @moduledoc """
  List and describe the various models available in the API. You can refer to
  the [Models](https://platform.openai.com/docs/models) documentation to
  understand what models are available and the differences between them.

  https://platform.openai.com/docs/api-reference/models
  """

  alias OpenAI.Client

  @doc """
  Lists the currently available models, and provides basic information about
  each one such as the owner and availability.
  """
  @spec list(Client.t(), Keyword.t()) :: Client.result()
  def list(client, opts \\ []) do
    client
    |> Client.get("/v1/models", opts)
    |> Client.handle_response(opts)
  end

  @doc """
  Retrieves a model instance, providing basic information about the model such
  as the owner and permissioning.
  """
  @spec retrieve(Client.t(), String.t(), Keyword.t()) :: Client.result()
  def retrieve(client, id, opts \\ []) when is_binary(id) do
    client
    |> Client.get("/v1/models/#{id}", opts)
    |> Client.handle_response(opts)
  end

  @doc """
  Delete a fine-tuned model. You must have the Owner role in your organization.
  """
  @spec delete(Client.t(), String.t(), Keyword.t()) :: Client.result()
  def delete(client, id, opts \\ []) do
    client
    |> Client.delete("/v1/models/#{id}", opts)
    |> Client.handle_response(opts)
  end
end
