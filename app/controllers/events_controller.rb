class EventsController < ApplicationController
	before_action :set_event, only: [:edit, :update, :show, :destroy]

def index
	@events = Event.all
end

def new
    if logged_in? && current_user.admin?
        @event = Event.new
    else
        flash[:danger] = "Only Admins can create events"
        redirect_to login_path
    end
end


def edit
	if logged_in? && current_user.admin?
        
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
end



def destroy
  @schedules = UserRegister.where(event_id: @event.id)  
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






private

    def event_params
        params.require(:event).permit(:name, :description, :time, :cost, :capacity, eventcat_ids: [], venue_ids: [], user_ids: [])
    end

    def set_event
        @event = Event.find(params[:id])
    end

end