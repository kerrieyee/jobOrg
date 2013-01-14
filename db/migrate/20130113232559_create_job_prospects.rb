class CreateJobProspects < ActiveRecord::Migration
  def change
    create_table :job_prospects do |t|
      t.string :company
      t.string :position
      t.integer :user_id

      t.timestamps
    end

    add_index :job_prospects, :user_id
  end

end
