class Document < ActiveRecord::Base
  attr_accessible :description, :name, :file, :event
  # validates :name, :event, presence: true
  belongs_to :event
  has_attached_file :file
  validates :file, :attachment_presence => true

end
