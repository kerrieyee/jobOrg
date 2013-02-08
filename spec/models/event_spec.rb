require 'spec_helper'

describe Event do
	[:contact, :contact_info, :conversation_date, :job_prospect].each do |attribute|
		it {should validate_presence_of attribute}
	end
	it {should have_many :documents}

end
