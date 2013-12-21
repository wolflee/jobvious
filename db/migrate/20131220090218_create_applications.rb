class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.string :name
      t.string :resume
      t.integer :user_id
      t.integer :job_id

      t.timestamps
    end
  end
end
