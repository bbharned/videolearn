class PagesController < ApplicationController
	#before_action :set_user, except: [:index]

    def index
        @user = User.new
        redirect_to dashboard_path if logged_in?
    end

    def dashboard
    	redirect_to root_path if !logged_in?
    end

    def lessonone

    end




    private

    

end