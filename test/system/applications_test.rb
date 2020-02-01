require "application_system_test_case"

class ApplicationsTest < ApplicationSystemTestCase
  setup do
    @application = applications(:one)
  end

  test "visiting the index" do
    visit applications_url
    assert_selector "h1", text: "Applications"
  end

  test "creating a Application" do
    visit applications_url
    click_on "New Application"

    fill_in "Email", with: @application.email
    fill_in "Experience", with: @application.experience
    fill_in "Job", with: @application.job_id
    fill_in "Joining date", with: @application.joining_date
    fill_in "Mobile", with: @application.mobile
    fill_in "Name", with: @application.name
    fill_in "Rejection reason", with: @application.rejection_reason
    fill_in "Resume", with: @application.resume
    fill_in "Status", with: @application.status_id
    click_on "Create Application"

    assert_text "Application was successfully created"
    click_on "Back"
  end

  test "updating a Application" do
    visit applications_url
    click_on "Edit", match: :first

    fill_in "Email", with: @application.email
    fill_in "Experience", with: @application.experience
    fill_in "Job", with: @application.job_id
    fill_in "Joining date", with: @application.joining_date
    fill_in "Mobile", with: @application.mobile
    fill_in "Name", with: @application.name
    fill_in "Rejection reason", with: @application.rejection_reason
    fill_in "Resume", with: @application.resume
    fill_in "Status", with: @application.status_id
    click_on "Update Application"

    assert_text "Application was successfully updated"
    click_on "Back"
  end

  test "destroying a Application" do
    visit applications_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Application was successfully destroyed"
  end
end
