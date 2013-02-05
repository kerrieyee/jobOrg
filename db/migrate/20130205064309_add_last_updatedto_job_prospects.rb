class AddLastUpdatedtoJobProspects < ActiveRecord::Migration
  def up
  	add_column :job_prospects, :last_updated, :timestamp
  end

  def down
  	remove_column :job_prospects, :last_updated
  end
end
