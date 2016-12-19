class QuizzesController < ApplicationController
	before_action :require_user
	before_action :require_admin, except: [:show]

	def index
		@quizzes = Quiz.all
	end

	def new
		@quiz = Quiz.new
		@availableq = Question.where.not(id: @questions)
		if @quiz.questions.any?
			@questions = @quiz.questions.all 
		else 
			@questions = nil
		end
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
		@questions = @quiz.questions.all 
		@availableq = Question.where.not(id: @questions)
		#@teams = Team.where.not(name: @team_exclude_list)
	end 

	def update
		@quiz = Quiz.find(params[:id])
		@questions = @quiz.questions.all
		if @quiz.update(quiz_params)
			flash[:success] = "Quiz name was successfully updated"
			redirect_to quizzes_path
		else
			render 'edit'
		end
	end

	# def quiz_submit
 #        @video = Video.find(params[:video_id])
 #        @quiz = Quiz.find(params[:quiz_id])
 #        flash[:success] = "You Rocked That quiz!"
 #        redirect_to dashboard_path
 #    end

	def show
		@quiz = Quiz.find(params[:id])
		@quiz_questions = @quiz.questions.all
	end

	def quiz_me
        @video = Video.find(params[:id])
        flash[:success] = "You Rocked That quizity quiz!"
        redirect_to dashboard_path
    end

    def quiz_submit
        @video = Video.find(params[:id])
        flash[:success] = "You Rocked That quiz!"
        redirect_to dashboard_path
    end



private

    def quiz_params
        params.require(:quiz).permit(:name, question_ids: [], video_ids:[], answer_ids:[])
    end

    # def question_params
    # 	params.require(:question).permit(:name, answer_ids: [])
    # end

    # def answer_params
    # 	params.require(:answer).permit(:name, :correct)
    # end

    def require_admin
		if !logged_in? || (logged_in? && !current_user.admin?)
			flash[:danger] = "Only Admins can perform that action"
			redirect_to root_path
		end
	end


end