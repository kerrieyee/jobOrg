class JobProspect < ActiveRecord::Base
  attr_accessible :company, :position, :user, :last_updated

  before_create :set_last_updated_to_now
  before_update :set_last_updated_to_now
  validates :company, :user, presence: true

  belongs_to :user
  has_many :events, :dependent => :destroy
  
  private

  def set_last_updated_to_now
    self.last_updated = Time.now
  end
end
