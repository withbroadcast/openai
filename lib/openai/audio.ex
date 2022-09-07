defmodule OpenAI.Audio do
  @moduledoc """
  Learn how to turn audio into text.

  Related guide: [Speech to text](https://platform.openai.com/docs/guides/speech-to-text)

  https://platform.openai.com/docs/api-reference/audio
  """

  alias OpenAI.Client

  @type create_transcription_params :: %{
    required(:file) => String.t(),
    required(:model) => String.t(),
    optional(:prompt) => String.t(),
    optional(:response_format) => String.t(),
    optional(:temperature) => float(),
    optional(:language) => String.t()
  }

  @doc """
  Transcribes audio into the input language.
  """
  @spec create_transcription(Client.t(), create_transcription_params(), Keyword.t()) :: Client.result()
  def create_transcription(client, params, opts \\ []) do
    client
    |> Client.post("/v1/audio/transcriptions", params, opts)
    |> Client.handle_response(opts)
  end

  @type create_translation_params :: %{
    required(:file) => String.t(),
    required(:model) => String.t(),
    optional(:prompt) => String.t(),
    optional(:response_format) => String.t(),
    optional(:temperature) => float()
  }

  @doc """
  Translates audio into English.
  """
  @spec create_translation(Client.t(), create_translation_params(), Keyword.t()) :: Client.result()
  def create_translation(client, params, opts \\ []) do
    client
    |> Client.post("/v1/audio/translations", params, opts)
    |> Client.handle_response(opts)
  end
end
