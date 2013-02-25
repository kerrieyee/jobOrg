require 'spec_helper'

describe JobProspect do
	[:company, :user].each do |attribute|
		it {should validate_presence_of attribute}
	end

	it {should belong_to :user}

	context "before filters" do
		let(:user){stub_model User, :id => 1, :name => "Gary"}
		describe "#before_create" do
			it "sets the last_updated attribute to the current time" do
				job_prospect = JobProspect.new(:company => "company", :user => user)
				job_prospect.last_updated.should be(nil)
				job_prospect.save
				job_prospect.last_updated.should_not be(nil)
			end
		end

		describe "#before_update" do
			let(:job_prospect){stub_model JobProspect, :company => "company", :last_updated => nil, :user => user}
			it "sets the last_updated attribute with the updated_at time" do
				job_prospect.update_attributes(:company => "company2")
				job_prospect.last_updated.should be_within(0.005).of(job_prospect.updated_at)
			end
		end
	end
end
