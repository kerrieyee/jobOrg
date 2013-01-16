class EventsController < ApplicationController
	def index
		@job_prospect = JobProspect.find(params[:job_prospect_id])
		@events = Event.where(:job_prospect_id => params[:job_prospect_id])
	end

	def new
		@event = Event.new
	end

	def create
		job_prospect = {:job_prospect => JobProspect.find(params[:job_prospect_id])}
		@event = Event.create(params[:event].merge(job_prospect))

		if @event.save
			flash[:success] = "Your event has been saved."
			redirect_to job_prospect_events_path
		else
			flash.now[:error] = "Invalid event.  #{display_errors(@event)}"
			render "new"
		end
	end

	def show
		@event = Event.find(params[:id])
	end

	def edit
		@event = Event.find(params[:id])
	end

	def update
		@event = Event.find(params[:id])
		job_prospect = {:job_prospect => @event.job_prospect}
	  if @event.update_attributes(params[:event].merge(job_prospect))
	  	flash[:success] = "Your event has been successfully updated!"
	   redirect_to job_prospect_events_path(@event.job_prospect)
	 	else
	 		flash.now[:error] = "Invalid event.  #{display_errors(@event)}"
	 		render "edit"
    end
  end

	def destroy
		@event = Event.find(params[:id])
		job_prospect = @event.job_prospect
		@event.destroy
		flash[:success] = "Your event has been deleted."
		redirect_to job_prospect_events_path(job_prospect)
	end

	private
	def display_errors(object)
		object.errors.full_messages.join(". ")
	end

end
