class EventAttendeesController < ApplicationController


	def checkin
    	@event = Event.find(params[:id])
      	@users = Attendee.all.order(:lastname)
      	@attendees = EventAttendee.all
    end


    def attended
    	@attendee = EventAttendee.where(event_id: params[:event_id], attendee_id: params[:attendee_id])
      	@attendee.first.toggle!(:checkedin)
      	redirect_to checkin_path(params[:event_id])
    end


end