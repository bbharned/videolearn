class EventsController < ApplicationController
	before_action :set_event, only: [:edit, :update, :show, :destroy]

def index
	@events = Event.all.order(:time)
end

def new
    if (logged_in? && current_user.admin?) || (logged_in? && current_user.evtadmin?)
        @event = Event.new
    else
        flash[:danger] = "Only Admins can create events"
        redirect_to login_path
    end
end


def edit
	if (logged_in? && current_user.admin?) || (logged_in? && current_user.evtadmin?)
        
    else
        flash[:danger] = "Only Admins can edit events"
        redirect_to login_path
    end
end


def create
        
        @event = Event.new(event_params)

        if @event.save
            flash[:success] = "Event successfully created"
            redirect_to events_path
        else
            render :new
        end
end

def update
    if @event.update(event_params)
        flash[:success] = "Event successfully updated"
        redirect_to events_path
    else
        render 'edit'
    end
end


def show
    @attendees = EventAttendee.where(event_id: @event.id).order(:lastname)
    @export = Attendee.where(id: @attendees.ids)

    respond_to do |format|
      format.html
      format.csv { send_data @export.to_csv, filename: "#{@event.name}-registered-#{Date.today}.csv" }
    end
end



def destroy
  @schedules = EventAttendee.where(event_id: @event.id)  
  if @event.destroy
    flash[:danger] = "Event has been deleted and removed."
    if @schedules.any?
        @schedules.destroy_all
    end
    redirect_to events_path
  else
    flash[:danger] = "There was a problem removing the event."
    redirect_to events_path
  end
end


def ereport
    if (logged_in? && current_user.admin?) || (logged_in? && current_user.evtadmin?)
        @events = Event.all.order(:endtime).reverse_order
        @allregistered = EventAttendee.all.order(:lastname)
    else
        flash[:danger] = "only admins can view reports"
        redirect_to events_path
    end
end




private

    def event_params
        params.require(:event).permit(:name, :description, :time, :endtime, :cost, :capacity, eventcat_ids: [], venue_ids: [], user_ids: [])
    end

    def set_event
        @event = Event.find(params[:id])
    end

end