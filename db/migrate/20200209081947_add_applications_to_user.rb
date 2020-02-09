class AddApplicationsToUser < ActiveRecord::Migration[6.0]
  def self.up
    add_column :applications, :user_id, :integer
    add_index 'applications', ['user_id'], :name => 'index_applications_on_user_id'
end

def self.down
    remove_column :applications, :user_id
end
end
