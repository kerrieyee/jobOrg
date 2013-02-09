require 'will_paginate/array'

class EventsController < ApplicationController
	before_filter :authenticate_user!

	def index
		job_prospect = JobProspect.find(params[:job_prospect_id])
		if correct_user?(job_prospect.user, current_user) 
			@job_prospect = job_prospect
			@events = Event.paginate(:page       => params[:page],
                           :per_page   => 8,
                           :order      => 'conversation_date DESC',
                           :conditions => { :job_prospect_id => @job_prospect.id })
		else
			redirect_unauthorized_user
		end
	end

	def new
		@event = Event.new
	end

	def create
		documents = params[:documents]
		job_prospect = {:job_prospect => JobProspect.find(params[:job_prospect_id])}
		@event = Event.new(params[:event].merge(job_prospect))
		
		if @event.save
			flash[:success] = "Your event has been saved."
			redirect_to job_prospect_events_path
		else
			flash.now[:error] = "Invalid event.  #{@event.display_errors}."
			render "new"
		end
	end

	def show
		event = Event.find(params[:id]) 
		authorize_user(event)
	end

	def edit
		event = Event.find(params[:id])
		authorize_user(event)
	end

	def update
		documents = params[:event][:documents]
		@event = Event.find(params[:id])
		job_prospect = {:job_prospect => @event.job_prospect}
		documents.each do |doc| 
			a = Document.create(:file => doc, :event => @event)
		end
		
	  if @event.update_attributes(params[:event].merge(job_prospect))
	  	flash[:success] = "Your event has been successfully updated!"
	   	redirect_to job_prospect_events_path(@event.job_prospect)
	 	else
	 		flash.now[:error] = "Invalid event.  #{@event.display_errors}."
	 		render "edit"
    end
  end

	def destroy
		@event = Event.find(params[:id])
		job_prospect = @event.job_prospect
		@event.destroy

		respond_to do |format|
			format.js
			format.html{redirect_to job_prospect_events_path(job_prospect)}
		end
	end

	def all_events
		@events = Event.all_events(current_user)
		@page_events = @events.paginate(	:page       => params[:page],
                           						:per_page   => 8,
                           						:order      => 'conversation_date DESC')
	end

	private

	def authorize_user(event)
		correct_user?(event.job_prospect.user, current_user) ? @event = event : redirect_unauthorized_user
	end

	
end
