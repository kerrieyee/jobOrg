require 'spec_helper'

describe "Events", js: true do
	include Warden::Test::Helpers
	let!(:event){Fabricate(:event)}
	let!(:event2){Fabricate(:event)}

	context "correct user is logged in" do
		before(:each) do 
			login_as event.job_prospect.user
		end

		describe "#index" do
			it "displays the events for the correct job prospect" do
				visit job_prospect_path(event.job_prospect)
				click_link "All #{event.job_prospect.company} Events"
				page.should have_content("Events for #{event.job_prospect.company}")
			end
		end

		describe "#create" do
			it "creates a new event when all required fields are filled in" do
				visit new_job_prospect_event_path(event.job_prospect)
				fill_in "event_contact", :with => "Harold"
				fill_in "event_contact_info", :with => "(999)999-9999"
				select('January', :from => 'event_conversation_date_2i')
				select('22', :from => 'event_conversation_date_3i')
				select('2013', :from => 'event_conversation_date_1i')
				click_button "Create Event"
				page.should have_content "Harold"
			end

			it "displays an error when certain fields are left blank" do
				visit new_job_prospect_event_path(event.job_prospect)
				fill_in "event_contact_info", :with => "(999)999-9999"
				select('January', :from => 'event_conversation_date_2i')
				select('22', :from => 'event_conversation_date_3i')
				select('2013', :from => 'event_conversation_date_1i')
				click_button "Create Event"
				page.should have_content "Invalid event. Contact can't be blank"
			end
		end

		describe "#delete" do
			it "should deletes a row from the events table when clicking on ok in the confirm window" do
				visit job_prospect_events_path(event.job_prospect)
				within ('#1') do
					click_link 'Delete' 
					page.driver.browser.switch_to.alert.accept
					#used to ok the confirrmation box
				end

				page.should_not have_content(event.contact)
			end

			it "should not delete a file from the events table when clicking on cancel in the confirm window" do
				visit job_prospect_events_path(event.job_prospect)
				within ('#1') do
					click_link 'Delete' 
					page.driver.browser.switch_to.alert.dismiss
					#used to cancel the confirrmation box
				end

				page.should have_content(event.contact)
			end
		end

		describe "#update" do
			it "updates the table on the events index page" do
				visit job_prospect_events_path(event.job_prospect)
				within ('#1') do
					click_link 'Edit' 
				end
				page.should have_content("Edit Event")
				fill_in "event_contact_info", :with => "At the end of the rainbow"
				click_button("Update Event")
				page.should have_content("At the end of the rainbow") 
			end
		end

		describe "#all_events" do
			it "only displays events from that user" do
				job_prospect = JobProspect.create(company: "alltech", user: event.job_prospect.user)
				event_one_two = Event.create(contact: "harry", conversation_date: Date.today, contact_info: "111 st", job_prospect: job_prospect)
				visit all_events_path
				debugger
				page.should have_content("harry")
				page.should have_content(event.contact) 
				page.should_not have_content(event2.contact_info)
			end
		end

	end 
end

