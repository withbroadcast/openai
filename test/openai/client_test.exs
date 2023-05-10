defmodule OpenAI.ClientTest do
  use OpenAI.Case
  alias OpenAI.Client

  describe "new/1" do
    test "creates a new client from application config" do
      Application.put_env(:openai_client, :api_key, "some-api-key")
      Application.put_env(:openai_client, :organization, "some-organization")

      # Does not raise.
      assert _ = Client.new()
    end

    test "raises when missing :api_key" do
      Application.put_env(:openai_client, :api_key, nil)
      Application.put_env(:openai_client, :organization, "some-organization")

      assert_raise RuntimeError, "OpenAI client missing :api_key", fn ->
        Client.new()
      end
    end

    test "raises when missing :organization" do
      Application.put_env(:openai_client, :api_key, "some-api-key")
      Application.put_env(:openai_client, :organization, nil)

      assert_raise RuntimeError, "OpenAI client missing :organization", fn ->
        Client.new()
      end
    end

    test "sets config from options" do
      Application.put_env(:openai_client, :api_key, nil)
      Application.put_env(:openai_client, :organization, nil)

      # Does not raise.
      assert _ = Client.new(api_key: "some-api-key", organization: "some-organization")
    end

    test "raises when missing :api_key with options" do
      Application.put_env(:openai_client, :api_key, nil)
      Application.put_env(:openai_client, :organization, nil)

      assert_raise RuntimeError, "OpenAI client missing :api_key", fn ->
        Client.new(organization: "some-organization")
      end
    end

    test "raises when missing :organization with options" do
      Application.put_env(:openai_client, :api_key, nil)
      Application.put_env(:openai_client, :organization, nil)

      assert_raise RuntimeError, "OpenAI client missing :organization", fn ->
        Client.new(api_key: "some-api-key")
      end
    end
  end
end
