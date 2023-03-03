defmodule OpenAI.ChatTest do
  use OpenAI.Case

  @model "gpt-3.5-turbo"
  @create_completion_response %{
    "id" => "chatcmpl-123",
    "object" => "chat.completion",
    "created" => 1_677_652_288,
    "choices" => [
      %{
        "index" => 0,
        "message" => %{
          "role" => "assistant",
          "content" => "\n\nHello there, how may I assist you today?"
        },
        "finish_reason" => "stop"
      }
    ],
    "usage" => %{
      "prompt_tokens" => 9,
      "completion_tokens" => 12,
      "total_tokens" => 21
    }
  }

  describe "create/3" do
    test "creates a completion", %{bypass: bypass, client: client} do
      Bypass.expect_once(bypass, "POST", "/v1/chat/completions", fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, Jason.encode!(@create_completion_response))
      end)

      {:ok, resp} =
        OpenAI.Chat.create_completion(client, %{
          model: @model,
          messages: [
            %{
              "role" => "user",
              "content" => "Hello!"
            }
          ]
        })

      assert resp == @create_completion_response
    end
  end
end
