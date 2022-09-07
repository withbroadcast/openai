defmodule OpenAI.ModelsTest do
  use OpenAI.Case

  @list_response %{
    "data" => [
      %{
        "id" => "model-id-0",
        "object" => "model",
        "owned_by" => "organization-owner",
        "permission" => []
      },
      %{
        "id" => "model-id-1",
        "object" => "model",
        "owned_by" => "organization-owner",
        "permission" => []
      },
      %{
        "id" => "model-id-2",
        "object" => "model",
        "owned_by" => "openai",
        "permission" => []
      },
    ],
    "object" => "list"
  }

  describe "list/3" do
    test "lists all models", %{bypass: bypass, client: client} do
      Bypass.expect_once(bypass, "GET", "/v1/models", fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, Jason.encode!(@list_response))
      end)

      {:ok, resp} = OpenAI.Models.list(client)

      assert resp == @list_response
    end
  end

  @retrieve_response %{
    "id" => "text-davinci-003",
    "object" => "model",
    "owned_by" => "openai",
    "permission" => []
  }

  describe "retrieve/3" do
    test "retrieves a model", %{bypass: bypass, client: client} do
      Bypass.expect_once(bypass, "GET", "/v1/models/text-davinci-003", fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, Jason.encode!(@retrieve_response))
      end)

      {:ok, resp} = OpenAI.Models.retrieve(client, "text-davinci-003")

      assert resp == @retrieve_response
    end
  end

  @delete_response %{
    "id" => "curieft-acmeco-2021-03-03-21-44-20",
    "object" => "model",
    "deleted" => true
  }

  describe "delete/3" do
    test "deletes a model", %{bypass: bypass, client: client} do
      Bypass.expect_once(bypass, "DELETE", "/v1/models/curieft-acmeco-2021-03-03-21-44-20", fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, Jason.encode!(@delete_response))
      end)

      {:ok, resp} = OpenAI.Models.delete(client, "curieft-acmeco-2021-03-03-21-44-20")

      assert resp == @delete_response
    end
  end
end
