class JobProspectsController < ApplicationController
	def index
		@job_prospects = JobProspect.where(:user_id => current_user.id)
	end

	def create
		@job_prospects = JobProspect.where(:user_id => current_user.id)
		@job_prospect = JobProspect.new(	:company => params[:job_prospect][:company],
																				:position => params[:job_prospect][:position],
																				:user => current_user)
		respond_to do |format|
			if @job_prospect.save
				format.html{redirect_to job_prospects_url}
				format.js
			else
				format.html{ render :action => "create"}
				format.js
     end			
		end
	end

	def show
		@job_prospect = JobProspect.find_by_id_and_user_id(params[:id], current_user.id)
		if @job_prospect
			@events = Event.where(:job_prospect_id => @job_prospect.id).order("conversation_date").limit(5)
		else
			redirect_to root_path
			flash[:error] = "You are not allowed to access this page!"
		end
	end

	def destroy
		@job_prospect = JobProspect.find(params[:id])
		@job_prospect.destroy
		respond_to do |format|
			format.html{redirect_to job_prospects_url}
			format.js
		end
	end

end


