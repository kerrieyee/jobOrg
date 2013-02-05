class JobProspectsController < ApplicationController
	respond_to :json, :html
	def index
		@job_prospects = JobProspect.where(:user_id => current_user.id)
		respond_with @job_prospects
	end

	def create
		@job_prospect = JobProspect.create(	:company => params[:job_prospect][:company],
																			:position => params[:job_prospect][:position],
																			:user => current_user)
		respond_with @job_prospect
	end

	def update
		@job_prospect = JobProspect.find(params[:id])
		@job_prospect.update_attributes(:company => params[:job_prospect][:company],
																			:position => params[:job_prospect][:position],
																			:user => current_user)

		respond_with(@job_prospect)
	end

	def show
		@job_prospect = JobProspect.find_by_id_and_user_id(params[:id], current_user.id)
		if @job_prospect
			@events = Event.where(:job_prospect_id => @job_prospect.id).order("conversation_date").limit(5)
			respond_with(@job_prospect, @events)
		else
			redirect_unauthorized_user
		end
	end

	def destroy
		@job_prospect = JobProspect.find(params[:id])
		respond_with(@job_prospect.destroy)
	end

end


