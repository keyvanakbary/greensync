defmodule Greensync.Store.Repo do
  use Ecto.Repo,
    otp_app: :greensync,
    adapter: Ecto.Adapters.MyXQL

  import Ecto.Query, only: [from: 2]

  alias Greenhousex.Harvest
  alias Greensync.Store.Model

  @type num_results :: integer

  @spec add_users([Harvest.User.t()]) :: num_results
  def add_users(users) do
    users
    |> Enum.map(&Model.User.from_harvest/1)
    |> bulk_insert(Model.User)
  end

  @spec add_job_stages([Harvest.JobStage.t()]) :: num_results
  def add_job_stages(job_stages) do
    job_stages
    |> Enum.map(&Model.JobStage.from_harvest/1)
    |> bulk_insert(Model.JobStage)
  end

  @spec add_jobs([Harvest.Job.t()]) :: num_results
  def add_jobs(jobs) do
    num =
      jobs
      |> Enum.map(&Model.Job.from_harvest/1)
      |> bulk_insert(Model.Job)

    jobs
    |> Enum.map(&Model.JobDepartment.from_harvest/1)
    |> List.flatten()
    |> bulk_insert(Model.JobDepartment)

    jobs
    |> Enum.map(&Model.JobOffice.from_harvest/1)
    |> List.flatten()
    |> bulk_insert(Model.JobOffice)

    num
  end

  @spec add_applications([Harvest.Application.t()]) :: num_results
  def add_applications(applications) do
    num =
      applications
      |> Enum.map(&Model.Application.from_harvest/1)
      |> bulk_insert(Model.Application)

    applications
    |> Enum.map(&Model.ApplicationJob.from_harvest/1)
    |> List.flatten()
    |> bulk_insert(Model.ApplicationJob)

    num
  end

  @spec add_scorecards([Harvest.Scorecard.t()]) :: num_results
  def add_scorecards(scorecards) do
    scorecards
    |> Enum.map(&Model.Scorecard.from_harvest/1)
    |> bulk_insert(Model.Scorecard)
  end

  @spec add_candidates([Harvest.Candidate.t()]) :: num_results
  def add_candidates(candidates) do
    candidates
    |> Enum.map(&Model.Candidate.from_harvest/1)
    |> bulk_insert(Model.Candidate)
  end

  @spec add_offices([Harvest.Office.t()]) :: num_results
  def add_offices(offices) do
    offices
    |> Enum.map(&Model.Office.from_harvest/1)
    |> bulk_insert(Model.Office)
  end

  @spec add_departments([Harvest.Department.t()]) :: num_results
  def add_departments(departments) do
    departments
    |> Enum.map(&Model.Department.from_harvest/1)
    |> bulk_insert(Model.Department)
  end

  def last_user_created_at(),
    do: query_latest_field(Model.User, :created_at)

  def last_application_applied_at(),
    do: query_latest_field(Model.Application, :applied_at)

  def last_job_created_at(),
    do: query_latest_field(Model.Job, :created_at)

  def last_job_stage_created_at(),
    do: query_latest_field(Model.JobStage, :created_at)

  def last_candidate_created_at(),
    do: query_latest_field(Model.Candidate, :created_at)

  def last_scorecard_created_at(),
    do: query_latest_field(Model.Scorecard, :created_at)

  defp query_latest_field(schema, field) do
    schema
    |> from(select: ^[field], order_by: ^[desc: field], limit: 1)
    |> one()
    |> extract_field(field)
  end

  defp extract_field(nil, _field), do: nil
  defp extract_field(result, field), do: Map.get(result, field)

  defp bulk_insert(entities, model) do
    entries = entities |> Enum.map(&to_map/1)
    {num, _} = insert_all(model, entries, on_conflict: :replace_all)
    num
  end

  defp to_map(entity) do
    Map.drop(entity, [:__struct__, :__meta__])
  end
end
