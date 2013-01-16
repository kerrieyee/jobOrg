class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :contact
      t.date :conversation_date
      t.time :conversation_time
      t.string :conversation_type
      t.string :contact_info
      t.string :notes
      t.integer :job_prospect_id

      t.timestamps
    end
    add_index :events, :job_prospect_id
  end
end
