class QuestionsController < ApplicationController
	before_action :require_user
	before_action :require_admin

	def index
		@questions = Question.all
	end


	def new
		@question = Question.new
		#@answer = Answer.new
	end



private

	def quiz_params
        params.require(:question).permit(:name)
    end

    def require_admin
		if !logged_in? || (logged_in? && !current_user.admin?)
			flash[:danger] = "Only Admins can perform that action"
			redirect_to root_path
		end
	end

end