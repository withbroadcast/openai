defmodule OpenAI.FineTunesTest do
  use OpenAI.Case

  @model "curie"

  @create_response %{
    "id" => "ft-AF1WoRqd3aJAHsqc9NY7iL8F",
    "object" => "fine-tune",
    "model" => @model,
    "created_at" => 1614807352,
    "events" => [
      %{
        "object" => "fine-tune-event",
        "created_at" => 1614807352,
        "level" => "info",
        "message" => "Job enqueued. Waiting for jobs ahead to complete. Queue number: 0."
      }
    ],
    "fine_tuned_model" => nil,
    "hyperparams" => %{
      "batch_size" => 4,
      "learning_rate_multiplier" => 0.1,
      "n_epochs" => 4,
      "prompt_loss_weight" => 0.1,
    },
    "organization_id" => "org-...",
    "result_files" => [],
    "status" => "pending",
    "validation_files" => [],
    "training_files" => [
      %{
        "id" => "file-XGinujblHPwGLSztz8cPS8XY",
        "object" => "file",
        "bytes" => 1547276,
        "created_at" => 1610062281,
        "filename" => "my-data-train.jsonl",
        "purpose" => "fine-tune-train"
      }
    ],
    "updated_at" => 1614807352,
  }



  describe "create/3" do
    test "creates a fine tune", %{bypass: bypass, client: client} do
      Bypass.expect_once(bypass, "POST", "/v1/fine-tunes", fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, Jason.encode!(@create_response))
      end)

      {:ok, resp} = OpenAI.FineTunes.create(client, %{
        training_file: "file-XGinujblHPwGLSztz8cPS8XY"
      })

      assert resp == @create_response
    end
  end

  @list_response %{
    "object" => "list",
    "data" => [
      %{
        "id" => "ft-AF1WoRqd3aJAHsqc9NY7iL8F",
        "object" => "fine-tune",
        "model" => @model,
        "created_at" => 1614807352,
        "fine_tuned_model" => nil,
        "hyperparams" => %{},
        "organization_id" => "org-...",
        "result_files" => [],
        "status" => "pending",
        "validation_files" => [],
        "training_files" => [],
        "updated_at" => 1614807352,
      }
    ]
  }


  describe "list/2" do
    test "lists fine tunes", %{bypass: bypass, client: client} do
      Bypass.expect_once(bypass, "GET", "/v1/fine-tunes", fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, Jason.encode!([@list_response]))
      end)

      {:ok, resp} = OpenAI.FineTunes.list(client)

      assert resp == [@list_response]
    end
  end

  @retrieve_response %{
    "id" => "ft-AF1WoRqd3aJAHsqc9NY7iL8F",
    "object" => "fine-tune",
    "model" => @model,
    "created_at" => 1614807352,
    "events" => [
      %{
        "object" => "fine-tune-event",
        "created_at" => 1614807352,
        "level" => "info",
        "message" => "Job enqueued. Waiting for jobs ahead to complete. Queue number: 0."
      },
      %{
        "object" => "fine-tune-event",
        "created_at" => 1614807356,
        "level" => "info",
        "message" => "Job started."
      },
      %{
        "object" => "fine-tune-event",
        "created_at" => 1614807861,
        "level" => "info",
        "message" => "Uploaded snapshot: curie:ft-acmeco-2021-03-03-21-44-20."
      },
      %{
        "object" => "fine-tune-event",
        "created_at" => 1614807864,
        "level" => "info",
        "message" => "Uploaded result files: file-QQm6ZpqdNwAaVC3aSz5sWwLT."
      },
      %{
        "object" => "fine-tune-event",
        "created_at" => 1614807864,
        "level" => "info",
        "message" => "Job succeeded."
      }
    ],
    "fine_tuned_model" => "curie:ft-acmeco-2021-03-03-21-44-20",
    "hyperparams" => %{
      "batch_size" => 4,
      "learning_rate_multiplier" => 0.1,
      "n_epochs" => 4,
      "prompt_loss_weight" => 0.1,
    },
    "organization_id" => "org-...",
    "result_files" => [
      %{
        "id" => "file-QQm6ZpqdNwAaVC3aSz5sWwLT",
        "object" => "file",
        "bytes" => 81509,
        "created_at" => 1614807863,
        "filename" => "compiled_results.csv",
        "purpose" => "fine-tune-results"
      }
    ],
    "status" => "succeeded",
    "validation_files" => [],
    "training_files" => [
      %{
        "id" => "file-XGinujblHPwGLSztz8cPS8XY",
        "object" => "file",
        "bytes" => 1547276,
        "created_at" => 1610062281,
        "filename" => "my-data-train.jsonl",
        "purpose" => "fine-tune-train"
      }
    ],
    "updated_at" => 1614807865,
  }

  describe "retrieve/3" do
    test "retrieves a fine-tine", %{bypass: bypass, client: client} do
      Bypass.expect_once(bypass, "GET", "/v1/fine-tunes/ft-AF1WoRqd3aJAHsqc9NY7iL8F", fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, Jason.encode!(@retrieve_response))
      end)

      {:ok, resp} = OpenAI.FineTunes.retrieve(client, "ft-AF1WoRqd3aJAHsqc9NY7iL8F")

      assert resp == @retrieve_response
    end
  end

  @cancel_response %{
    "id" => "ft-xhrpBbvVUzYGo8oUO1FY4nI7",
    "object" => "fine-tune",
    "model" => @model,
    "created_at" => 1614807770,
    "events" => [
      %{
        "object" => "fine-tune-event",
        "created_at" => 1614807352,
        "level" => "info",
        "message" => "Job enqueued. Waiting for jobs ahead to complete. Queue number: 0."
      },
      %{
        "object" => "fine-tune-event",
        "created_at" => 1614807356,
        "level" => "info",
        "message" => "Job started."
      },
      %{
        "object" => "fine-tune-event",
        "created_at" => 1614807861,
        "level" => "info",
        "message" => "Uploaded snapshot: curie:ft-acmeco-2021-03-03-21-44-20."
      },
      %{
        "object" => "fine-tune-event",
        "created_at" => 1614807864,
        "level" => "info",
        "message" => "Uploaded result files: file-QQm6ZpqdNwAaVC3aSz5sWwLT."
      },
      %{
        "object" => "fine-tune-event",
        "created_at" => 1614807864,
        "level" => "info",
        "message" => "Job succeeded."
      }
    ],
    "fine_tuned_model" => nil,
    "hyperparams" => %{},
    "organization_id" => "org-...",
    "result_files" => [],
    "status" => "cancelled",
    "validation_files" => [],
    "training_files" => [
      %{
        "id" => "file-XGinujblHPwGLSztz8cPS8XY",
        "object" => "file",
        "bytes" => 1547276,
        "created_at" => 1610062281,
        "filename" => "my-data-train.jsonl",
        "purpose" => "fine-tune-train"
      }
    ],
    "updated_at" => 1614807789,
  }

  describe "cancel/3" do
    test "cancels a fine-tine", %{bypass: bypass, client: client} do
      Bypass.expect_once(bypass, "POST", "/v1/fine-tunes/ft-AF1WoRqd3aJAHsqc9NY7iL8F/cancel", fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, Jason.encode!(@cancel_response))
      end)

      {:ok, resp} = OpenAI.FineTunes.cancel(client, "ft-AF1WoRqd3aJAHsqc9NY7iL8F")

      assert resp == @cancel_response
    end
  end

  @events_response %{
    "object" => "list",
    "data" => [
      %{
        "object" => "fine-tune-event",
        "created_at" => 1614807352,
        "level" => "info",
        "message" => "Job enqueued. Waiting for jobs ahead to complete. Queue number: 0."
      },
      %{
        "object" => "fine-tune-event",
        "created_at" => 1614807356,
        "level" => "info",
        "message" => "Job started."
      },
      %{
        "object" => "fine-tune-event",
        "created_at" => 1614807861,
        "level" => "info",
        "message" => "Uploaded snapshot: curie:ft-acmeco-2021-03-03-21-44-20."
      },
      %{
        "object" => "fine-tune-event",
        "created_at" => 1614807864,
        "level" => "info",
        "message" => "Uploaded result files: file-QQm6ZpqdNwAaVC3aSz5sWwLT."
      },
      %{
        "object" => "fine-tune-event",
        "created_at" => 1614807864,
        "level" => "info",
        "message" => "Job succeeded."
      }
    ]
  }

  describe "list_events/3" do
    test "lists events for a fine-tune", %{bypass: bypass, client: client} do
      Bypass.expect_once(bypass, "GET", "/v1/fine-tunes/ft-AF1WoRqd3aJAHsqc9NY7iL8F/events", fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, Jason.encode!(@events_response))
      end)

      {:ok, resp} = OpenAI.FineTunes.list_events(client, "ft-AF1WoRqd3aJAHsqc9NY7iL8F")

      assert resp == @events_response
    end
  end
end
