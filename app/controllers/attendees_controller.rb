class AttendeesController < ApplicationController
	before_action :require_user, except: [:new, :create]
	before_action :require_admin, only: [:index, :edit, :destroy]

	def index
		@events = Event.all
		@attendees = Attendee.all
	end

	def new
	    @attendee = Attendee.new
	    @event = Event.find(params[:event_id])
	end


	def edit
		@attendee = Attendee.find(params[:id])
		@event = EventAttendee.where(:attendee_id => @attendee.id).last
	end


	def create       
        @attendee = Attendee.new(attendee_params)
        @event = Event.find(params[:attendee][:event_id])
    	if @attendee.save
        	@registered = EventAttendee.new(:attendee_id => @attendee.id, :event_id => @event.id)
            if @registered.save
            	flash[:success] = "You Are now registered. Thanks for registering"
            	redirect_to events_path
            else
            	flash[:danger] = "There was a problem registering for that event"
            	redirect_to events_path
            end    
        else
            render :new
        end
	end

	def destroy
        @attendee = Attendee.find(params[:id])
        @attendee.destroy
        flash[:danger] = "Event attendee has been deleted"
        redirect_to attendees_path
    end

	

	private

		def attendee_params
			params.require(:attendee).permit(:firstname, :lastname, :company, :email, :relationship, event_ids: [])
		end

		def require_admin
            if logged_in? and !current_user.admin? || !logged_in?
                flash[:danger] = "Only admin users can perform that action"
                redirect_to events_path
            end
        end

end