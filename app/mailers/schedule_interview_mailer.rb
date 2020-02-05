class ScheduleInterviewMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.schedule_intervieww_mailer.schedule_interview.subject
  #
  def schedule_interview(interviewer, application, interview)
   @interviewer = interviewer
   @application = application
   @interview = interview
   mail to: interviewer.email, subject: "An interview has been scheduled on #{@interview.scheduled_date.to_s}"
  end

  def notify_application_update(interviewer, application)
    @interviewer = interviewer
    @application = application
    mail to: interviewer.email, subject: "Application Status has been updated to #{@application.status}"
  end

  def release_offer_letter(application)
    @application = application
    # mail to: interviewer.email, subject: "Offer has been extended to #{@application.emaill}"
    mail to: application.email, subject: "Pleased to extend the offer letter"
  end
end
