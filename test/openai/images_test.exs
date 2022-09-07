defmodule OpenAI.ImagesTest do
  use OpenAI.Case

  @response %{
    "created" => 1589478378,
    "data" => [
      %{
        "url" => "https://openai.com/images/some-image.png"
      },
      %{
        "url" => "https://openai.com/images/some-other-image.png"
      }
    ]
  }


  describe "create/3" do
    test "creates an image", %{bypass: bypass, client: client} do
      Bypass.expect_once(bypass, "POST", "/v1/images/generations", fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, Jason.encode!(@response))
      end)

      {:ok, resp} = OpenAI.Images.create(client, %{
        prompt: "A cute baby sea otter",
        n: 2,
        size: "1024x1024"
      })

      assert resp == @response
    end
  end

  describe "create_edit/3" do
    test "creates an image edit", %{bypass: bypass, client: client} do
      Bypass.expect_once(bypass, "POST", "/v1/images/edits", fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, Jason.encode!(@response))
      end)

      {:ok, resp} = OpenAI.Images.create_edit(client, %{
        prompt: "A cute baby sea otter wearing a beret",
        image: "@otter.png",
        mask: "@mask.png",
        n: 2,
        size: "1024x1024"
      })

      assert resp == @response
    end
  end

  describe "create_variation/3" do
    test "creates an image variation", %{bypass: bypass, client: client} do
      Bypass.expect_once(bypass, "POST", "/v1/images/variations", fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, Jason.encode!(@response))
      end)

      {:ok, resp} = OpenAI.Images.create_variation(client, %{
        image: "@otter.png",
        n: 2,
        size: "1024x1024"
      })

      assert resp == @response
    end
  end
end
