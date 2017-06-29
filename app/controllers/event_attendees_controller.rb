class EventAttendeesController < ApplicationController

  	def checkin
      if (logged_in? && current_user.admin?) || (logged_in? && current_user.evtadmin?)
        @event = Event.find(params[:id])
        @users = Attendee.all.order(:lastname)
        @attendees = EventAttendee.where(event_id: @event.id).order(:lastname)
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

    def sms 
      if (logged_in? && current_user.admin?) || (logged_in? && current_user.evtadmin?)
        @event = Event.find(params[:id])
        @attendees = EventAttendee.where(event_id: @event.id).order(:lastname)
        @evt_users = Attendee.where(id: @attendees.ids)
        @phones = Array.new
        @evt_users.each do |role|
          if role.phone != nil && role.phone != ""
            @phones.push role.phone
          end
        end
      else
        flash[:danger] = "Only admins can perform that action"
        redirect_to events_path
      end
    end

    def sendit
      @message = params[:message][:sms_message]
      @event = Event.find(params[:id])
      @phones = params[:message][:phones]
      @phones.each do |number|
        send_blowio(@message, number)
      end
      redirect_to event_path(@event)
    end

    private 

    def send_blowio(message, number)
      blowerio = RestClient::Resource.new(ENV['BLOWERIO_URL'])
      blowerio['/messages'].post :to => "'+1"+number+"'", :message => message
    end

      

end