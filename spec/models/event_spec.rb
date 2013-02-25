require 'spec_helper'

describe Event do
	[:contact, :contact_info, :conversation_date, :job_prospect].each do |attribute|
		it {should validate_presence_of attribute}
	end
	it {should have_many :documents}

	describe "#update_job_prospect_last_updated" do
		let(:user){stub_model User, :id => 1, :name => "Gary"}
		let(:job_prospect){stub_model JobProspect, 	:company => "company", 
																								:last_updated => nil, 
																								:user => user}
		let(:event){stub_model Event, :id => 1, :job_prospect => job_prospect}

		it "should update job_prospect.last_updated for that event" do 
			event.update_job_prospect_last_updated
			event.job_prospect.last_updated.should_not be(nil)
		end
	end

	describe "#display_errors" do 
		it "displays_errors for the object" do
			event = Event.new
			event.save
			event.display_errors.should eq("Contact can't be blank. Contact info can't be blank. Conversation date can't be blank. Job prospect can't be blank")
		end
	end

	describe "#all_events" do
		let(:job_prospect1){Fabricate(:job_prospect)}
		let(:job_prospect2){Fabricate(:job_prospect)}
		it "returns all the events for a given user" do
			Event.create(:contact => "Phil", :contact_info => "123-4567", :conversation_date => Date.today, :job_prospect => job_prospect1)
			Event.create(:contact => "Hal", :contact_info => "123-4567", :conversation_date => Date.today, :job_prospect => job_prospect2)
			Event.create(:contact => "Art", :contact_info => "123-4567", :conversation_date => Date.today, :job_prospect => job_prospect1)
			events = Event.all_events(job_prospect1.user)
			events.count.should eq(2)
		end
 end
end
