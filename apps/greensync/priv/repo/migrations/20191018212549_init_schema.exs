defmodule Migrations.InitSchema do
  use Ecto.Migration

  def change do

    create table(:users) do
      add :name, :string, null: false
      add :first_name, :string
      add :last_name, :string
      add :primary_email_address, :string, null: false
      add :site_admin, :boolean, null: false
      add :disabled, :boolean, null: false
      add :created_at, :utc_datetime, null: false
      add :updated_at, :utc_datetime, null: false
    end

    create table(:candidates) do
      add :created_at, :utc_datetime, null: false
      add :updated_at, :utc_datetime, null: false
      add :title, :string
    end

    create table(:departments) do
      add :name, :string, null: false
      add :parent_id, references(:departments, on_delete: :delete_all), null: true
    end

    create table(:offices) do
      add :name, :string, null: false
      add :location_name, :string
      add :parent_id, references(:offices, on_delete: :delete_all), null: true
    end

    create table(:jobs) do
      add :name, :string, null: false
      add :confidential, :boolean, null: false
      add :status, :string, null: false
      add :opened_at, :utc_datetime
      add :created_at, :utc_datetime, null: false
      add :updated_at, :utc_datetime, null: false
      add :closed_at, :utc_datetime
    end

    create table(:job_stages) do
      add :name, :string, null: false
      add :job_id, references(:jobs, on_delete: :delete_all)
      add :created_at, :utc_datetime, null: false
      add :updated_at, :utc_datetime, null: false
    end

    create table(:job_offices, primary_key: false) do
      add :office_id, references(:offices, on_delete: :delete_all), null: false
      add :job_id, references(:jobs, on_delete: :delete_all), null: false
    end

    create table(:job_departments, primary_key: false) do
      add :department_id, references(:departments, on_delete: :delete_all), null: false
      add :job_id, references(:jobs, on_delete: :delete_all), null: false
    end

    create table(:applications) do
      add :prospect, :boolean, null: false
      add :candidate_id, references(:candidates, on_delete: :delete_all)
      add :status, :string, null: false
      add :current_stage_id, references(:job_stages, on_delete: :delete_all)
      add :applied_at, :utc_datetime, null: false
      add :last_activity_at, :utc_datetime, null: false
      add :prospective_office_id, references(:offices, on_delete: :delete_all), null: true
      add :prospective_department_id, references(:departments, on_delete: :delete_all), null: true
      add :rejected_at, :utc_datetime
    end

    create table(:application_jobs, primary_key: false) do
      add :application_id, references(:applications, on_delete: :delete_all), null: false
      add :job_id, references(:jobs, on_delete: :delete_all), null: false
    end

    create table(:scorecards) do
      add :candidate_id, references(:candidates, on_delete: :delete_all)
      add :application_id, references(:applications, on_delete: :delete_all)
      add :overall_recommendation, :string, null: false
      add :submitter_id, references(:users, on_delete: :delete_all), null: false
      add :submitted_at, :utc_datetime, null: false
      add :interview, :string, null: false
      add :interviewer_id, references(:users, on_delete: :delete_all), null: false
      add :interviewed_at, :utc_datetime, null: false
      add :created_at, :utc_datetime, null: false
      add :updated_at, :utc_datetime, null: false
    end
  end
end
