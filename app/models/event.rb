class Event < ActiveRecord::Base
  attr_accessible :contact, :contact_info, :conversation_date, :job_prospect, 
  								:notes, :conversation_time, :conversation_type, :updated_at, :documents_attributes
  validates :contact, :contact_info, :conversation_date, :job_prospect, presence: true
  belongs_to :job_prospect
  has_many :documents, :dependent => :destroy
  accepts_nested_attributes_for :documents


  def update_job_prospect
  	self.job_prospect.last_updated = Time.now
  	self.job_prospect.save
  end
end
