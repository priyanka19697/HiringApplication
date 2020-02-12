class AddStatusToApplicationsAndInterviews < ActiveRecord::Migration[6.0]
  def change
    add_column :applications, :application_status, :string
    add_column :interviews, :interview_status, :string
  end
end
