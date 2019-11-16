defmodule Greenhousex.Harvest do
  use Tesla

  adapter Tesla.Adapter.Hackney, recv_timeout: 30_000

  plug(Tesla.Middleware.JSON)
  plug(Tesla.Middleware.BaseUrl, "https://harvest.greenhouse.io/v1")

  plug(Tesla.Middleware.BasicAuth, %{
    username: Application.get_env(:greenhousex, :greenhouse_api_token),
    password: ""
  })

  plug(Tesla.Middleware.Retry,
    delay: 10000,
    max_retries: 5,
    max_delay: 10000,
    should_retry: fn
      {:ok, %{status: status}} when status in [429, 500] -> true
      {:ok, _} -> false
      {:error, _} -> true
    end
  )

  alias Greenhousex.Harvest.{Candidate, Scorecard, User}

  def get_users(query \\ []) do
    "/users"
    |> stream_get(query: query)
    |> Stream.map(&parse_users/1)
  end

  defp parse_users({:ok, %{status: 200, body: users}}) do
    {:ok, Enum.map(users, &User.from_map/1)}
  end

  defp parse_users({_, %{body: body}}), do: {:error, body}

  def get_candidates(query \\ []) do
    "/candidates"
    |> stream_get(query: query)
    |> Stream.map(&parse_candidates/1)
  end

  defp parse_candidates({:ok, %{status: 200, body: candidates}}) do
    {:ok, Enum.map(candidates, &Candidate.from_map/1)}
  end

  defp parse_candidates({_, %{body: body}}), do: {:error, body}

  def get_scorecards(query \\ []) do
    "/scorecards"
    |> stream_get(query: query)
    |> Stream.map(&parse_scorecards/1)
  end

  defp parse_scorecards({:ok, %{status: 200, body: scorecards}}) do
    {:ok, Enum.map(scorecards, &Scorecard.from_map/1)}
  end

  defp parse_scorecards({_, %{body: body}}), do: {:error, body}

  def get_applications(query \\ []) do
    "/applications"
    |> stream_get(query: query)
    |> Stream.map(&parse_applications/1)
  end

  defp parse_applications({:ok, %{status: 200, body: applications}}) do
    {:ok, Enum.map(applications, &Greenhousex.Harvest.Application.from_map/1)}
  end

  defp parse_applications({_, %{body: body}}), do: {:error, body}

  def get_jobs(query \\ []) do
    "/jobs"
    |> stream_get(query: query)
    |> Stream.map(&parse_jobs/1)
  end

  defp parse_jobs({:ok, %{status: 200, body: jobs}}) do
    {:ok, Enum.map(jobs, &Greenhousex.Harvest.Job.from_map/1)}
  end

  defp parse_jobs({_, %{body: body}}), do: {:error, body}

  def get_job_stages(query \\ []) do
    "/job_stages"
    |> stream_get(query: query)
    |> Stream.map(&parse_job_stages/1)
  end

  defp parse_job_stages({:ok, %{status: 200, body: job_stages}}) do
    {:ok, Enum.map(job_stages, &Greenhousex.Harvest.JobStage.from_map/1)}
  end

  defp parse_job_stages({_, %{body: body}}), do: {:error, body}

  def get_offices(query \\ []) do
    "/offices"
    |> stream_get(query: query)
    |> Stream.map(&parse_offices/1)
  end

  defp parse_offices({:ok, %{status: 200, body: offices}}) do
    {:ok, Enum.map(offices, &Greenhousex.Harvest.Office.from_map/1)}
  end

  defp parse_offices({_, %{body: body}}), do: {:error, body}

  def get_departments(query \\ []) do
    "/departments"
    |> stream_get(query: query)
    |> Stream.map(&parse_departments/1)
  end

  defp parse_departments({:ok, %{status: 200, body: departments}}) do
    {:ok, Enum.map(departments, &Greenhousex.Harvest.Department.from_map/1)}
  end

  defp parse_departments({_, %{body: body}}), do: {:error, body}

  defp stream_get(url, opts) do
    Stream.resource(
      fn ->
        query = Keyword.get(opts, :query, [])
        Keyword.get(query, :page, 1)
      end,
      fn
        nil ->
          {:halt, nil}

        page ->
          new_query =
            opts
            |> Keyword.get(:query, [])
            |> Keyword.put(:page, page)
            |> remove_nil_params()
            |> datetimes_to_iso8601()

          new_opts = Keyword.put(opts, :query, new_query)
          result = get(url, new_opts)

          if has_next?(result) do
            {[result], page + 1}
          else
            {[result], nil}
          end
      end,
      fn a -> a end
    )
  end

  defp remove_nil_params(query) do
    Enum.filter(query, fn {_k, v} -> !is_nil(v) end)
  end

  defp datetimes_to_iso8601(query) do
    Enum.map(query, fn
      {k, %DateTime{} = d} -> {k, DateTime.to_iso8601(d)}
      kv -> kv
    end)
  end

  defp has_next?({:ok, response}) do
    case Tesla.get_header(response, "link") do
      link_header when is_binary(link_header) ->
        Regex.match?(~r/<([^>]+)>; rel="next"/, link_header)

      _ ->
        false
    end
  end

  defp has_next?(_), do: false
end
