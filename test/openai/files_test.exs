defmodule OpenAI.FilesTest do
  use OpenAI.Case

  @list_response %{
    "data" => [
      %{
        "id" => "file-ccdDZrC3iZVNiQVeEA6Z66wf",
        "object" => "file",
        "bytes" => 175,
        "created_at" => 1613677385,
        "filename" => "train.jsonl",
        "purpose" => "search"
      },
      %{
        "id" => "file-XjGxS3KTG0uNmNOK362iJua3",
        "object" => "file",
        "bytes" => 140,
        "created_at" => 1613779121,
        "filename" => "puppy.jsonl",
        "purpose" => "search"
      }
    ],
    "object" => "list"
  }

  describe "list/3" do
    test "lists all files", %{bypass: bypass, client: client} do
      Bypass.expect_once(bypass, "GET", "/v1/files", fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, Jason.encode!(@list_response))
      end)

      {:ok, resp} = OpenAI.Files.list(client)

      assert resp == @list_response
    end
  end

  @upload_response %{
    "id" => "file-XjGxS3KTG0uNmNOK362iJua3",
    "object" => "file",
    "bytes" => 140,
    "created_at" => 1613779121,
    "filename" => "mydata.jsonl",
    "purpose" => "fine-tune"
  }

  describe "upload/3" do
    test "uploads a file", %{bypass: bypass, client: client} do
      Bypass.expect_once(bypass, "POST", "/v1/files", fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, Jason.encode!(@upload_response))
      end)

      {:ok, resp} = OpenAI.Files.upload(client, %{file: "@mydata.jsonl", purpose: "fine-tune"})

      assert resp == @upload_response
    end
  end

  @delete_response %{
    "id" => "file-XjGxS3KTG0uNmNOK362iJua3",
    "object" => "file",
    "deleted" => true
  }

  describe "delete/3" do
    test "deletes a file", %{bypass: bypass, client: client} do
      Bypass.expect_once(bypass, "DELETE", "/v1/files/file-XjGxS3KTG0uNmNOK362iJua3", fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, Jason.encode!(@delete_response))
      end)

      {:ok, resp} = OpenAI.Files.delete(client, "file-XjGxS3KTG0uNmNOK362iJua3")

      assert resp == @delete_response
    end
  end

  @retrieve_response %{
    "id" => "file-XjGxS3KTG0uNmNOK362iJua3",
    "object" => "file",
    "bytes" => 140,
    "created_at" => 1613779657,
    "filename" => "mydata.jsonl",
    "purpose" => "fine-tune"
  }

  describe "retrieve/3" do
    test "retrieves a file", %{bypass: bypass, client: client} do
      Bypass.expect_once(bypass, "GET", "/v1/files/file-XjGxS3KTG0uNmNOK362iJua3", fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, Jason.encode!(@retrieve_response))
      end)

      {:ok, resp} = OpenAI.Files.retrieve(client, "file-XjGxS3KTG0uNmNOK362iJua3")

      assert resp == @retrieve_response
    end
  end
end
