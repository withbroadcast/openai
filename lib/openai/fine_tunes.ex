defmodule OpenAI.FineTunes do
  @moduledoc """
  Manage fine-tuning jobs to tailor a model to your specific training data.

  Related guide: [Fine-tune models](https://platform.openai.com/docs/guides/fine-tuning)

  https://platform.openai.com/docs/api-reference/fine-tunes
  """

  alias OpenAI.Client

  @type create_params :: %{
    required(:training_file) => String.t(),
    optional(:validation_file) => String.t(),
    optional(:model) => String.t(),
    optional(:n_epochs) => integer(),
    optional(:batch_size) => integer(),
    optional(:learning_rate_multiplier) => float(),
    optional(:prompt_loss_weight) => float(),
    optional(:compute_classification_metrics) => boolean(),
    optional(:classification_n_classes) => integer(),
    optional(:classification_positive_class) => String.t(),
    optional(:classification_betas) => integer() | float(),
    optional(:suffix) => String.t()
  }

  @doc """
  Creates a job that fine-tunes a specified model from a given dataset.

  Response includes details of the enqueued job including job status and the
  name of the fine-tuned models once complete.
  """
  @spec create(Client.t(), create_params(), Keyword.t()) :: Client.result()
  def create(client, params, opts \\ []) do
    client
    |> Client.post("/v1/fine-tunes", params, opts)
    |> Client.handle_response(opts)
  end

  @doc """
  List your organization's fine-tuning jobs
  """
  @spec list(Client.t(), Keyword.t()) :: Client.result()
  def list(client, opts \\ []) do
    client
    |> Client.get("/v1/fine-tunes", opts)
    |> Client.handle_response(opts)
  end

  @doc """
  Gets info about the fine-tuning job
  """
  @spec retrieve(Client.t(), String.t(), Keyword.t()) :: Client.result()
  def retrieve(client, id, opts \\ []) do
    client
    |> Client.get("/v1/fine-tunes/#{id}", opts)
    |> Client.handle_response(opts)
  end

  @doc """
  Immediately cancel a fine-tune job
  """
  @spec cancel(Client.t(), String.t(), Keyword.t()) :: Client.result()
  def cancel(client, id, opts \\ []) do
    client
    |> Client.post("/v1/fine-tunes/#{id}/cancel", opts)
    |> Client.handle_response(opts)
  end

  @doc """
  Get fine-grained status updates for a fine-tune job.
  """
  @spec list_events(Client.t(), String.t(), Keyword.t()) :: Client.result()
  def list_events(client, id, opts \\ []) do
    # TODO: handle response streaming!

    client
    |> Client.get("/v1/fine-tunes/#{id}/events", opts)
    |> Client.handle_response(opts)
  end
end
