defmodule OpenAI.EditsTest do
  use OpenAI.Case

  @model "text-davinci-edit-001"
  @create_response %{
    "object" => "edit",
    "created" => 1589478378,
    "choices" => [
      %{
        "text" => "What day of the week is it?",
        "index" => 0,
      }
    ],
    "usage" => %{
      "prompt_tokens" => 25,
      "completion_tokens" => 32,
      "total_tokens" => 57
    }
  }

  describe "create/3" do
    test "creates an edit", %{bypass: bypass, client: client} do
      Bypass.expect_once(bypass, "POST", "/v1/edits", fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, Jason.encode!(@create_response))
      end)

      {:ok, resp} = OpenAI.Edits.create(client, %{
        model: @model,
        input: "What day of the wek is it?",
        instructions: "Fix the spelling mistakes"
      })

      assert resp == @create_response
    end
  end
end
