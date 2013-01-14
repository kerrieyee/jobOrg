class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  validates :name, :password, presence: true
  validates :email, presence: true, uniqueness: true
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  has_many :job_prospects
  # attr_accessible :title, :body
end
