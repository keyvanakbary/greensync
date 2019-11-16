defmodule Greensync.Sync do
  require Logger

  alias Greenhousex.Harvest

  alias Greensync.Store.Repo

  @batch_size 500

  def all() do
    sync_departments()
    sync_offices()

    now = DateTime.utc_now()
    sync_users(now)
    sync_candidates(now)
    sync_jobs(now)
    sync_job_stages(now)
    sync_applications(now)
    sync_scorecards(now)
  end

  defp sync_users(now) do
    Logger.info("Harvesting users...")

    last_created_at = Repo.last_user_created_at()

    Harvest.get_users(per_page: @batch_size, updated_after: last_created_at, created_before: now)
    |> Stream.map(fn {:ok, users} -> Repo.add_users(users) end)
    |> Enum.each(&log_harvests/1)
  end

  defp sync_departments() do
    Logger.info("Harvesting departments...")

    Harvest.get_departments(per_page: @batch_size)
    |> Stream.map(fn {:ok, departments} -> Repo.add_departments(departments) end)
    |> Enum.each(&log_harvests/1)
  end

  defp sync_offices() do
    Logger.info("Harvesting offices...")

    Harvest.get_offices(per_page: @batch_size)
    |> Stream.map(fn {:ok, offices} -> Repo.add_offices(offices) end)
    |> Enum.each(&log_harvests/1)
  end

  defp sync_applications(now) do
    Logger.info("Harvesting applications...")

    last_applied_at = Repo.last_application_applied_at()

    Harvest.get_applications(
      per_page: @batch_size,
      last_activity_after: last_applied_at,
      created_before: now
    )
    |> Stream.map(fn {:ok, applications} -> Repo.add_applications(applications) end)
    |> Enum.each(&log_harvests/1)
  end

  defp sync_jobs(now) do
    Logger.info("Harvesting jobs...")

    last_created_at = Repo.last_job_created_at()

    Harvest.get_jobs(per_page: @batch_size, updated_after: last_created_at, created_before: now)
    |> Stream.map(fn {:ok, jobs} -> Repo.add_jobs(jobs) end)
    |> Enum.each(&log_harvests/1)
  end

  defp sync_job_stages(now) do
    Logger.info("Harvesting job stages...")

    last_created_at = Repo.last_job_stage_created_at()

    Harvest.get_job_stages(
      per_page: @batch_size,
      updated_after: last_created_at,
      created_before: now
    )
    |> Stream.map(fn {:ok, job_stages} -> Repo.add_job_stages(job_stages) end)
    |> Enum.each(&log_harvests/1)
  end

  defp sync_candidates(now) do
    Logger.info("Harvesting candidates...")

    last_created_at = Repo.last_candidate_created_at()

    Harvest.get_candidates(
      per_page: @batch_size,
      updated_after: last_created_at,
      created_before: now
    )
    |> Stream.map(fn {:ok, candidates} -> Repo.add_candidates(candidates) end)
    |> Enum.each(&log_harvests/1)
  end

  defp sync_scorecards(now) do
    Logger.info("Harvesting scorecards...")

    last_created_at = Repo.last_scorecard_created_at()

    Harvest.get_scorecards(
      per_page: @batch_size,
      updated_after: last_created_at,
      created_before: now
    )
    |> Stream.map(fn {:ok, scorecards} -> Repo.add_scorecards(scorecards) end)
    |> Enum.each(&log_harvests/1)
  end

  defp log_harvests(num),
    do: Logger.info("Harvested #{num}", ansi_color: :green)
end
