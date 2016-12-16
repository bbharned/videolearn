class PagesController < ApplicationController
	before_action :require_user, except: [:index]

    def index
        @user = User.new
        redirect_to dashboard_path if logged_in?
    end

    def dashboard
    	@videos = Video.all
    end

    

    private

    

end