class QuizzesController < ApplicationController
before_action :require_user
before_action :require_admin, except: [:show]

def index
	@quizzes = Quiz.all
end

def new
	@quiz = Quiz.new
end

def create

    @quiz = Quiz.new(quiz_params)

    if @quiz.save
        flash[:success] = "Quiz was sucessfully created"
        redirect_to quizzes_path
    else
        render 'new'
    end

end

def edit
	@quiz = Quiz.find(params[:id])
end 

def update
	@quiz = Quiz.find(params[:id])
	if @quiz.update(quiz_params)
		flash[:success] = "Quiz name was successfully updated"
		redirect_to quizzes_path
	else
		render 'edit'
	end
end

def show
	@quiz = Quiz.find(params[:id])
	#@category_videos = @category.videos.all
end



private

    def quiz_params
        params.require(:quiz).permit(:name)
    end

    def require_admin
		if !logged_in? || (logged_in? && !current_user.admin?)
			flash[:danger] = "Only Admins can perform that action"
			redirect_to root_path
		end
	end


end