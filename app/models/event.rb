class Event < ActiveRecord::Base
  attr_accessible :contact, :contact_info, :conversation_date, :job_prospect, :notes, :conversation_time, :conversation_type
  validates :contact, :contact_info, :conversation_date, :job_prospect, presence: true
  belongs_to :job_prospect
end
