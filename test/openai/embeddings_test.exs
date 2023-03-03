defmodule OpenAI.EmbeddingsTest do
  use OpenAI.Case

  @model "text-embedding-ada-002"
  @create_embedding_response %{
    "object" => "list",
    "data" => [
      %{
        "object" => "text_embedding",
        "model" => "text-embedding-ada-002",
        "embedding" => [
          0.000
        ],
        "index" => 0
      }
    ],
    "model" => @model,
    "usage" => %{
      "prompt_tokens" => 0,
      "total_tokens" => 0
    }
  }

  describe "create/3" do
    test "creates an embedding", %{bypass: bypass, client: client} do
      Bypass.expect_once(bypass, "POST", "/v1/embeddings", fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, Jason.encode!(@create_embedding_response))
      end)

      {:ok, resp} =
        OpenAI.Embeddings.create(client, %{
          model: "text-embedding-ada-002",
          input: "The food was delicious and the waiter..."
        })

      assert resp == @create_embedding_response
    end
  end
end
