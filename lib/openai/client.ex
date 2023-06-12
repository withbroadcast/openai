defmodule OpenAI.Client do
  alias OpenAI.Config

  @default_base_url "https://api.openai.com"

  @type client :: Tesla.Client.t()
  @type t :: client()
  @type url :: Tesla.Env.url()
  @type body :: Tesla.Env.body()
  @type result :: {:ok, body() | function()} | {:error, term()}

  @type new_client_opt ::
          {:api_key, String.t()}
          | {:base_url, String.t()}
          | {:organization, String.t()}

  @type new_client_opts :: [new_client_opt]

  @doc """
  Initialize a new client for the OpenAI API.

  ## Options

  - `:api_key` - API key to use for the client.
  - `:base_url` - URL for the OpenAI API.
  - `:organization` - specifies which organization to use for requests.
  """
  @spec new(new_client_opts()) :: client()
  def new(opts \\ []) do
    base_url = Config.get(opts, :base_url, @default_base_url)
    api_key = fetch_config!(:api_key, opts)
    organization = fetch_config!(:organization, opts)

    middleware = [
      {Tesla.Middleware.BaseUrl, base_url},
      Tesla.Middleware.JSON,
      {Tesla.Middleware.Headers, build_headers(api_key, organization)}
    ]

    adapter = {Tesla.Adapter.Mint, [timeout: 30_000, mode: :passive]}

    Tesla.client(middleware, adapter)
  end

  defp fetch_config!(key, opts) do
    case Config.get(opts, key) do
      nil ->
        raise RuntimeError, "OpenAI client missing :#{key}"

      value ->
        value
    end
  end

  defp build_headers(api_key, organization) do
    api_key
    |> auth_headers(organization)
    |> put_header("user-agent", "openai-elixir")
  end

  defp put_header(headers, key, value) do
    [{key, value} | headers]
  end

  defp auth_headers(api_key, organization) do
    [
      {"authorization", "Bearer #{api_key}"},
      {"openai-organization", organization}
    ]
  end

  @doc false
  @spec get(client(), url(), Keyword.t()) :: result()
  def get(client, url, opts \\ []) do
    Tesla.get(client, url, opts)
  end

  @doc false
  @spec post(client(), url(), body(), Keyword.t()) :: result()
  def post(client, url, body, opts \\ []) do
    Tesla.post(client, url, body, opts)
  end

  @doc false
  @spec delete(client(), url(), Keyword.t()) :: result()
  def delete(client, url, opts \\ []) do
    Tesla.delete(client, url, opts)
  end

  @doc false
  @spec handle_response(result(), Keyword.t()) :: {:ok, body()} | {:error, term()}
  def handle_response(response, opts \\ [])

  def handle_response({:ok, %Tesla.Env{status: status, body: body}}, _opts) when status >= 400,
    do: {:error, body}

  def handle_response({:ok, %Tesla.Env{body: body}}, _opts), do: {:ok, body}

  def handle_response({:error, _reason} = err, _opts), do: err

  @doc false
  @spec with_stream_opts(map(), Keyword.t()) :: Keyword.t()
  def with_stream_opts(params, opts \\ [])

  def with_stream_opts(%{stream: true}, opts) do
    # This looks weird, but is the format that Tesla requires in order to
    # properly set the adapter options.
    Keyword.put(opts, :opts, adapter: [body_as: :stream])
  end

  def with_stream_opts(_params, opts), do: opts
end
