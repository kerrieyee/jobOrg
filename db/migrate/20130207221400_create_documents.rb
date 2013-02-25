class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :name
      t.string :description
      t.attachment :file
      t.integer :event_id

      t.timestamps
    end
    add_index :documents, :event_id
  end
end
