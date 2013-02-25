require 'spec_helper'

describe Document do
	[:name, :event].each do |attribute|
		it {should validate_presence_of attribute}
	end

	it {should belong_to :event}

end
