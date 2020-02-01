class CreateInterviews < ActiveRecord::Migration[6.0]
  def change
    create_table :interviews do |t|
      t.references :application, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :scheduled_date
      t.references :status, null: false, foreign_key: true
      t.text :interview_feedback

      t.timestamps
    end
  end
end
