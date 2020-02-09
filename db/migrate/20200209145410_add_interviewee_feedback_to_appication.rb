class AddIntervieweeFeedbackToAppication < ActiveRecord::Migration[6.0]
  def self.up
    add_column :applications, :interviewee_feedback, :text
end

def self.down
    remove_column :applications, :interviewee_feedback
end
end
