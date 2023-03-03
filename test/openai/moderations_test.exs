defmodule OpenAI.ModerationsTest do
  use OpenAI.Case

  @model "text-moderation-stable"

  @create_response %{
    "id" => "modr-5MWoLO",
    "model" => @model,
    "results" => [
      %{
        "categories" => %{
          "hate" => false,
          "hate/threatening" => true,
          "self-harm" => false,
          "sexual" => false,
          "sexual/minors" => false,
          "violence" => true,
          "violence/graphic" => false
        },
        "category_scores" => %{
          "hate" => 0.22714105248451233,
          "hate/threatening" => 0.4132447838783264,
          "self-harm" => 0.005232391878962517,
          "sexual" => 0.01407341007143259,
          "sexual/minors" => 0.0038522258400917053,
          "violence" => 0.9223177433013916,
          "violence/graphic" => 0.036865197122097015
        },
        "flagged" => true
      }
    ]
  }

  describe "create/3" do
    test "creates a moderation", %{bypass: bypass, client: client} do
      Bypass.expect_once(bypass, "POST", "/v1/moderations", fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, Jason.encode!(@create_response))
      end)

      {:ok, resp} =
        OpenAI.Moderations.create(client, %{
          input: "I want to kill them."
        })

      assert resp == @create_response
    end
  end
end
