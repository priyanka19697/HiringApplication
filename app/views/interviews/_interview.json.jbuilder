json.extract! interview, :id, :application_id, :user_id, :scheduled_date, :interview_status, :interview_feedback, :created_at, :updated_at
json.url interview_url(interview, format: :json)
