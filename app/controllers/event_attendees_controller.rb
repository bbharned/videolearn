class EventAttendeesController < ApplicationController

  	def checkin
      if logged_in? && current_user.admin?
        @event = Event.find(params[:id])
        @users = Attendee.all.order(:lastname)
        @attendees = EventAttendee.all.order(:lastname)
      else
        flash[:danger] = "Only admins can perform that action"
        redirect_to events_path
      end
    end


    def attended
    	@attendee = EventAttendee.where(event_id: params[:event_id], attendee_id: params[:attendee_id])
      @attendee.first.toggle!(:checkedin)
      redirect_to checkin_path(params[:event_id])
    end

    private

      

end