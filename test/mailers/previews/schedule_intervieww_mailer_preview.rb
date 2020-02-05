# Preview all emails at http://localhost:3000/rails/mailers/schedule_intervieww_mailer
class ScheduleInterviewwMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/schedule_intervieww_mailer/schedule_interview
  def schedule_interview
    ScheduleInterviewwMailer.schedule_interview
  end

end
