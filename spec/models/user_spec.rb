require 'spec_helper'

describe User do
	subject{Fabricate(:user)}

  [:name, :password, :email].each do |field|
  	it {should validate_presence_of field}
  end

  it {should validate_uniqueness_of :email}
  it {should have_many :job_prospects}
end
