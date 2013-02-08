class Event < ActiveRecord::Base
  attr_accessible :contact, :contact_info, :conversation_date, :job_prospect, 
  								:notes, :conversation_time, :conversation_type, :updated_at, :documents_attributes
  validates :contact, :contact_info, :conversation_date, :job_prospect, presence: true
  belongs_to :job_prospect
  has_many :documents, :dependent => :destroy
  accepts_nested_attributes_for :documents
  
  before_create :update_job_prospect_last_updated  
  before_update :update_job_prospect_last_updated 

  def update_job_prospect_last_updated
  	self.job_prospect.last_updated = Time.now
  	self.job_prospect.save
  end

  def display_errors
    self.errors.full_messages.join(". ")
  end

  def self.all_events(actual_user)
    events = []
    self.all.each {|e| events << e if e.job_prospect.user == actual_user}
    events
  end


end
