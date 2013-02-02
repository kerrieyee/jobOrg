class JobProspectsController < ApplicationController
	respond_to :json
	def index
		@job_prospects = JobProspect.paginate(:page => params[:page],
                           :per_page   => 8,
                           :order      => 'created_at DESC',
                           :conditions => { :user_id => current_user.id })
		respond_with @job_prospects
	end

	# def new
	# 	@job_prospect=JobProspect.new
	# 	respond_to do |format| 
	# 		format.html { render :action => "new" }
	# 		format.js
	# 	end
	# end


	def create
		@job_prospect = JobProspect.new(	:company => params[:job_prospect][:company],
																			:position => params[:job_prospect][:position],
																			:user => current_user)
		@job_prospect.save ? respond_with(@job_prospect) : respond_with(@job_prospect, :status => unprocessable_entity)
	end

	# def edit
	# 	@job_prospect = JobProspect.find(params[:id])
	# 	respond_to { |format| format.js }
	# end 

	def update
		@job_prospect = JobProspect.find(params[:id])

		@job_prospect.update_attributes(params[:job_prospect]) ? respond_with(@job_prospect) : respond_with(@job_prospect, :status => unprocessable_entity)
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


