class JobProspect < ActiveRecord::Base
  attr_accessible :company, :position, :user

  validates :company, :user, presence: true

  belongs_to :user
  has_many :events, :dependent => :destroy
end
