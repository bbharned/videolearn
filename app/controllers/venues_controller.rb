class VenuesController < ApplicationController
    #before_action :require_user, except: [:index, :show]
    before_action :require_admin, except: [:index, :show]


    def index
        @venues = Venue.all
    end

    def new
        @venue = Venue.new
    end



    def create
        @venue = Venue.new(venue_params)
        if @venue.save
            flash[:success] = "Venue was created successfully"
            redirect_to venues_path
        else
            render 'new'
        end
    end

    def edit
        @venue = Venue.find(params[:id])
    end

    def update
        @venue = Venue.find(params[:id])
        if @venue.update(venue_params)
            flash[:success] = "Venue name was successfully updated"
            redirect_to venues_path
        else
            render 'edit'
        end
    end

    def show
        @venue = Venue.find(params[:id])
    end

    def destroy
      @venue = Venue.find(params[:id])
      if @venue.destroy
        flash[:success] = "Event venue has been removed."
        redirect_to venues_path
      else
        flash[:danger] = "There was a problem removing the event venue."
        redirect_to venues_path
      end
    end




private 

    def venue_params
        params.require(:venue).permit(:name, :street, :city, :state, :zipcode, event_ids: [])
    end

    def require_admin
        if !logged_in? || !current_user.evtadmin?
            flash[:danger] = "You are not permitted to perform that action"
            redirect_to root_path
        end
    end


end