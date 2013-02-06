require 'spec_helper'

describe "JobProspects", js: true do
	include Warden::Test::Helpers
	let!(:job_prospect){Fabricate(:job_prospect)}
	let!(:job_prospect2){Fabricate(:job_prospect)}
	context "if user is not logged in" do
		it "doesn't let unauthorized user view job prospects" do
			visit root_path
			page.should have_content("You need to sign in or sign up before continuing.")
		end
	end

	context "if the correct user is logged in" do
		before(:each) do
			login_as job_prospect.user, :scope => :user
		end

		after(:each) do
			logout(:user)
		end

		describe "#index" do

			it "should display all of the current user job_prospects" do
				visit root_path
				page.should have_content job_prospect.company
				page.should_not have_content job_prospect2.position
			end
		end

		describe "#create" do
			it "should add a new Job Prospect to the table" do
				visit root_path
				fill_in 'new_job_prospect_company', :with => "DBC"
				fill_in 'new_job_prospect_position', :with => "Student"
				click_button "Add"
				page.should have_content("DBC")
			end
		end

		describe "#destroy" do
			it "should delete a file from the job prospects table when clicking on ok in the confirm window" do
				visit root_path
				within ('#1') do
					click_button 'Delete' 
					page.driver.browser.switch_to.alert.accept
					#used to ok the confirrmation box
				end

				page.should_not have_content(job_prospect.position)
			end

			it "should not delete a file from the job prospects table when clicking on cancel in the confirm window" do
				visit root_path
				within ('#1') do
					click_button 'Delete' 
					page.driver.browser.switch_to.alert.dismiss
					#used to cancel the confirrmation box
				end

				page.should have_content(job_prospect.company)
			end
		end

		describe "#edit" do
			it "should show the updated table with changes when edited" do
				visit root_path
				within ("#1") do 
					click_button 'Edit'
				end
				fill_in 'edit_job_prospect_company', :with => "Orange Juice"
				click_button("Update Job Prospect")
				page.should have_content("Orange Juice") 
			end
		end

		describe "#show" do
			it "when the company name link is clicked it should go to the show page for that job_prospect" do
				visit root_path
				within ("#1") do 
					click_link "#{job_prospect.company}"
				end	
				page.should have_content("All #{job_prospect.company} Events")
			end
		end


	end
end


		