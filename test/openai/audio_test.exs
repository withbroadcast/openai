defmodule OpenAI.AudioTest do
  use OpenAI.Case

  @model "whisper-1"

  @transcription_response %{
    "text" => "Imagine the wildest idea that you've ever had, and you're curious about how it might scale to something that's a 100, a 1,000 times bigger. This is a place where you can get to do that."
  }

  @translation_response %{
    "text" => "Hello, my name is Wolfgang and I come from Germany. Where are you heading today?"
  }

  describe "create_transcription/3" do
    test "creates a transcription", %{bypass: bypass, client: client} do
      Bypass.expect_once(bypass, "POST", "/v1/audio/transcriptions", fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, Jason.encode!(@transcription_response))
      end)

      {:ok, resp} = OpenAI.Audio.create_transcription(client, %{
        model: @model,
        file: "audio.mp3"
      })

      assert resp == @transcription_response
    end
  end

  describe "create_translation/3" do
    test "creates a translation", %{bypass: bypass, client: client} do
      Bypass.expect_once(bypass, "POST", "/v1/audio/translations", fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, Jason.encode!(@translation_response))
      end)

      {:ok, resp} = OpenAI.Audio.create_translation(client, %{
        model: @model,
        file: "german.m4a"
      })

      assert resp == @translation_response
    end
  end
end
