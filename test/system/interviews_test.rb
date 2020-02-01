require "application_system_test_case"

class InterviewsTest < ApplicationSystemTestCase
  setup do
    @interview = interviews(:one)
  end

  test "visiting the index" do
    visit interviews_url
    assert_selector "h1", text: "Interviews"
  end

  test "creating a Interview" do
    visit interviews_url
    click_on "New Interview"

    fill_in "Application", with: @interview.application_id
    fill_in "Interview feedback", with: @interview.interview_feedback
    fill_in "Scheduled date", with: @interview.scheduled_date
    fill_in "Status", with: @interview.status_id
    fill_in "User", with: @interview.user_id
    click_on "Create Interview"

    assert_text "Interview was successfully created"
    click_on "Back"
  end

  test "updating a Interview" do
    visit interviews_url
    click_on "Edit", match: :first

    fill_in "Application", with: @interview.application_id
    fill_in "Interview feedback", with: @interview.interview_feedback
    fill_in "Scheduled date", with: @interview.scheduled_date
    fill_in "Status", with: @interview.status_id
    fill_in "User", with: @interview.user_id
    click_on "Update Interview"

    assert_text "Interview was successfully updated"
    click_on "Back"
  end

  test "destroying a Interview" do
    visit interviews_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Interview was successfully destroyed"
  end
end
