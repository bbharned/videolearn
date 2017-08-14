class EventAttendeesController < ApplicationController
  before_action :set_phones, only: [:sendit]

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
        @phones = []
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

      @phones.each do |number|
        @number = "+1" + number
        send_blowio(@message, @number)
      end

      flash[:success] = "Your SMS messages were sent"
      redirect_to event_path(@event)

      # if send_blowio()
      #   flash[:success] = "Your SMS messages were sent"
      #   redirect_to event_path(@event)
      # else
      #   flash[:danger] = "Your SMS messages did not send completely"
      #   redirect_to event_path(@event)
      # end
      
    end

    private 

    def send_blowio(message, number)
      blowerio = RestClient::Resource.new(ENV['BLOWERIO_URL'])
      blowerio['/messages'].post :to => number, :message => message
    end

    def set_phones
        @event = Event.find(params[:id])
        @attendees = EventAttendee.where(event_id: @event.id).order(:lastname)
        @evt_users = Attendee.where(id: @attendees.ids)
        @evt_users = Attendee.where(id: @attendees.ids)
        @phones = []
        @evt_users.each do |role|
          if role.phone != nil && role.phone != ""
            @phones.push role.phone
          end
        end
    end
      

end