class EventcatsController < ApplicationController
	before_action :require_admin, except: [:index, :show]

	def index
		@ecats = Eventcat.all
	end

    def new
        @ecat = Eventcat.new
    end

	def edit
        @ecat = Eventcat.find(params[:id])
    end


    def update
        @ecat = Eventcat.find(params[:id])
        if @ecat.update(ecategory_params)
            flash[:success] = "Category name was successfully updated"
            redirect_to eventcat_path(@ecat)
        else
            render 'edit'
        end
    end

	def show
		@ecat = Eventcat.find(params[:id])
        @ecat_events = @ecat.events
	end



private

	def ecategory_params
        params.require(:eventcat).permit(:name)
    end

    def require_admin
        if (logged_in? && current_user.evtadmin?) || (logged_in? && current_user.admin?)

        else 
            flash[:danger] = "Only admins can perform that action"
            redirect_to eventcats_path
        end
    end


end