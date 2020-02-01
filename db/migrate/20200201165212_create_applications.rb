class CreateApplications < ActiveRecord::Migration[6.0]
  def change
    create_table :applications do |t|
      t.string :name
      t.string :email
      t.string :mobile
      t.integer :experience
      t.string :resume
      t.references :status, null: false, foreign_key: true
      t.references :job, null: false, foreign_key: true
      t.datetime :joining_date
      t.text :rejection_reason

      t.timestamps
    end
  end
end
