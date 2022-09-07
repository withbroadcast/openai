defmodule OpenAI.CompletionsTest do
  use OpenAI.Case

  @model "text-davinci-003"
  @create_completion_response %{
    "id" => "cmpl-uqkvlQyYK7bGYrRHQ0eXlWi7",
    "object" => "text_completion",
    "created" => 1589478378,
    "model" => @model,
    "choices" => [
      %{
        "text" => "\n\nThis is indeed a test",
        "index" => 0,
        "logprobs" => nil,
        "finish_reason" => "length"
      }
    ],
    "usage" => %{
      "prompt_tokens" => 5,
      "completion_tokens" => 7,
      "total_tokens" => 12
    }
  }

  describe "create/3" do
    test "creates a completion", %{bypass: bypass, client: client} do
      Bypass.expect_once(bypass, "POST", "/v1/completions", fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, Jason.encode!(@create_completion_response))
      end)

      {:ok, resp} = OpenAI.Completions.create(client, %{
        model: @model,
        prompt: "Say this is a test",
        max_tokens: 7,
        temperature: 0,
        top_p: 1,
        n: 1,
        stream: false,
        logprobs: nil,
        stop: "\n"
      })

      assert resp == @create_completion_response
    end
  end
end
