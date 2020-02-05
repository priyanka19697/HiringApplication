require 'test_helper'

class ScheduleInterviewwMailerTest < ActionMailer::TestCase
  test "schedule_interview" do
    mail = ScheduleInterviewwMailer.schedule_interview
    assert_equal "Schedule interview", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
