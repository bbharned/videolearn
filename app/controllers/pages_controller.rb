class PagesController < ApplicationController
	before_action :require_user, except: [:index]

    def index
        @user = User.new
        redirect_to dashboard_path if logged_in?
    end

    def dashboard
    	@videos = Video.all
    	@user = User.find(current_user.id)
        # put in badge detection here.
        @badge = UserBadge.where(user_id: @user.id).take
    end

    

    private

    

end