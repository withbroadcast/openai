defmodule OpenAI.Images do
  @moduledoc """
  Given a prompt and/or an input image, the model will generate a new image.

  Related guide: [Image generation](https://platform.openai.com/docs/guides/images)

  https://platform.openai.com/docs/api-reference/images
  """

  alias OpenAI.Client

  @type create_params :: %{
          required(:prompt) => String.t(),
          optional(:n) => integer(),
          optional(:size) => String.t(),
          optional(:response_format) => String.t(),
          optional(:user) => String.t()
        }

  @doc """
  Creates an image given a prompt.
  """
  @spec create(Client.t(), create_params(), Keyword.t()) :: Client.result()
  def create(client, params, opts \\ []) do
    client
    |> Client.post("/v1/images/generations", params, opts)
    |> Client.handle_response(opts)
  end

  @type create_edit_params :: %{
          required(:image) => String.t(),
          optional(:mask) => String.t(),
          required(:prompt) => String.t(),
          optional(:n) => integer(),
          optional(:size) => String.t(),
          optional(:response_format) => String.t(),
          optional(:user) => String.t()
        }

  @doc """
  Creates an edited or extended image given an original image and a prompt.
  """
  @spec create_edit(Client.t(), create_edit_params(), Keyword.t()) :: Client.result()
  def create_edit(client, params, opts \\ []) do
    client
    |> Client.post("/v1/images/edits", params, opts)
    |> Client.handle_response(opts)
  end

  @type create_variation_params :: %{
          required(:image) => String.t(),
          optional(:n) => integer(),
          optional(:size) => String.t(),
          optional(:response_format) => String.t(),
          optional(:user) => String.t()
        }

  @doc """
  Creates a variation of a given image.
  """
  @spec create_variation(Client.t(), create_variation_params(), Keyword.t()) :: Client.result()
  def create_variation(client, params, opts \\ []) do
    client
    |> Client.post("/v1/images/variations", params, opts)
    |> Client.handle_response(opts)
  end
end
