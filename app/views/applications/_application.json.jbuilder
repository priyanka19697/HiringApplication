json.extract! application, :id, :name, :email, :mobile, :experience, :resume, :application_status, :job_id, :joining_date, :rejection_reason, :created_at, :updated_at
json.url application_url(application, format: :json)
