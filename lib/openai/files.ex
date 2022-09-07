defmodule OpenAI.Files do
  @moduledoc """
  Files are used to upload documents that can be used with features like
  [Fine-tuning](https://platform.openai.com/docs/api-reference/fine-tunes).

  https://platform.openai.com/docs/api-reference/files
  """

  alias OpenAI.Client

  @doc """
  Returns a list of files that belong to the user's organization.
  """
  @spec list(Client.t(), Keyword.t()) :: Client.result()
  def list(client, opts \\ []) do
    client
    |> Client.get("/v1/files", opts)
    |> Client.handle_response(opts)
  end

  @type upload_params :: %{
    required(:file) => String.t(),
    required(:purpose) => String.t()
  }

  @doc """
  Upload a file that contains document(s) to be used across various endpoints/features.
  Currently, the size of all the files uploaded by one organization can be up to 1 GB.
  Please contact us if you need to increase the storage limit.
  """
  @spec upload(Client.t(), upload_params(), Keyword.t()) :: Client.result()
  def upload(client, params, opts \\ []) do
    client
    |> Client.post("/v1/files", params, opts)
    |> Client.handle_response(opts)
  end

  @doc """
  Delete a file.
  """
  @spec delete(Client.t(), String.t(), Keyword.t()) :: Client.result()
  def delete(client, id, opts \\ []) do
    client
    |> Client.delete("/v1/files/#{id}", opts)
    |> Client.handle_response(opts)
  end

  @doc """
  Returns information about a specific file.
  """
  @spec retrieve(Client.t(), String.t(), Keyword.t()) :: Client.result()
  def retrieve(client, id, opts \\ []) do
    client
    |> Client.get("/v1/files/#{id}", opts)
    |> Client.handle_response(opts)
  end

  @doc """
  Returns the content of the specified file.
  """
  @spec retrieve_content(Client.t(), String.t(), Keyword.t()) :: Client.result()
  def retrieve_content(client, id, opts \\ []) do
    client
    |> Client.get("/v1/files/#{id}/content", opts)
    |> Client.handle_response(opts)
  end
end
