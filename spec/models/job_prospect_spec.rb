require 'spec_helper'

describe JobProspect do
	subject{Fabricate(:job_prospect)}
	[:company, :user].each do |attribute|
		it {should validate_presence_of attribute}
	end

	it {should belong_to :user}
	
end
