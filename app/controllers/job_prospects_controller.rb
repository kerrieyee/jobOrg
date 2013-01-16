class JobProspectsController < ApplicationController
	def index
		@job_prospects = JobProspect.where(:user_id => current_user.id)
		@job_prospect = JobProspect.new
	end

	def create
		@job_prospects = JobProspect.where(:user_id => current_user.id)
		@job_prospect = JobProspect.create(	:company => params[:job_prospect][:company],
																				:position => params[:job_prospect][:position],
																				:user => current_user)
		respond_to do |format|
			if @job_prospect.save
				format.js
			else
				#need error handling
				# format.json{ render json: @job_prospect.to_json}
			end
		end
	end

	def show
		@job_prospect = JobProspect.find(params[:id])
	end

	def destroy
		@job_prospect = JobProspect.find(params[:id])
		@job_prospect.destroy
		respond_to do |format|
			format.js
		end
	end

end


