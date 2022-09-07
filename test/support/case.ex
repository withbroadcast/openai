defmodule OpenAI.Case do
  use ExUnit.CaseTemplate

  using do
    quote do
      import OpenAI.Case
    end
  end

  setup do
    clear_application_env()

    bypass = Bypass.open()
    url = "http://localhost:#{bypass.port}"

    client = OpenAI.Client.new([
      base_url: url,
      api_key: "some-api-key",
      organization: "some-organization"
    ])

    {:ok, bypass: bypass, client: client}
  end

  # Completely clears out the application environment for the :openai application.
  def clear_application_env do
    Application.put_all_env([{:openai, []}])
  end
end
