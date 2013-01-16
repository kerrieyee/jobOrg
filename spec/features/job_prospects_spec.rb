require 'spec_helper'

describe "JobProspects", js: true do
	include Warden::Test::Helpers
	let!(:job_prospect){Fabricate(:job_prospect)}
	let!(:job_prospect2){Fabricate(:job_prospect)}
	context "if user is not logged in" do
		it "doens't let unauthorized user view job prospects" do
			visit job_prospects_path
			page.should have_content("You need to sign in or sign up before continuing.")
		end
	end

	context "if the correct user is logged in" do
		before(:each) do
			login_as job_prospect.user, :scope => :user
		end

		describe "#index" do

			it "should display all of the current user job_prospects" do
				visit job_prospects_path
				page.should have_content job_prospect.company
				page.should_not have_content job_prospect2.company
			end
		end

		describe "#create" do
			#need to fix ajax to get this to pass

			it "should add a new Job Prospect to the table" do
				pending
				visit job_prospects_path
				fill_in 'job_prospect_company', :with => "DBC"
				fill_in 'job_prospect_position', :with => "Student"
				click_button "Create Job prospect"
				Capybara.default_wait_time = 5
				#Changed default wait time to wait for the AJAX to load
				page.should have_content("DBC")
			end
		end

		describe "#destroy" do
			it "should delete a file from the job prospects table" do
				visit job_prospects_path
				within (:css, 'li##{job_prospect.id}') do
					click_link "Delete"
				end
				page.should_not have_content(job_prospect.company)
			end
		end
	end
end

		