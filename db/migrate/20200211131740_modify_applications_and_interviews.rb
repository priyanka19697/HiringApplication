class ModifyApplicationsAndInterviews < ActiveRecord::Migration[6.0]
  def change
    remove_index "applications", name: "index_applications_on_status_id"
    remove_index "interviews", name: "index_interviews_on_status_id"
    remove_column :applications, :status_id, :integer
    remove_column :interviews, :status_id, :integer
  end
end
