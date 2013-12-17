class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :location
      t.text :description
      t.text :contact
      t.string :company
      t.string :url

      t.timestamps
    end
  end
end
