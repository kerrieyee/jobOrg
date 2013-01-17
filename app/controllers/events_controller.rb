class EventsController < ApplicationController
	def index
		@job_prospect = JobProspect.find(params[:job_prospect_id])
		@events = Event.where(:job_prospect_id => @job_prospect.id).order("conversation_date")
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
		respond_to do |format|
			format.html{redirect_to job_prospect_events_path(job_prospect)}
			format.js
		end
	end

	def all_events
		@event = Event.all
	end

	private
	def display_errors(object)
		object.errors.full_messages.join(". ")
	end

end
