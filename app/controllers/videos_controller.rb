class VideosController < ApplicationController
	before_action :require_user
    before_action :is_admin?, only: [:index, :new, :create, :edit, :update, :destroy]
	before_action :set_video, only: [:edit, :update, :show]
    before_action :quiz_answers, only: [:quiz_submit]
	

	def index
		@videos = Video.all
	end

	def new
		@video = Video.new
        # @question = Question.new
        # @answer = Answer.new
	end

	def create

		@video = Video.new(video_params)

        if @video.save
            flash[:success] = "Video information has been saved"
            redirect_to videos_path
        else
            render 'new'
        end

	end


	def edit
       @quizzes = @video.quizzes 
    end


    def show
        if @video.quizzes.any?
            @quizzes = @video.quizzes
            @count = nil
        else
            @quizzes = nil
        end
    end


    def update
    	if @video.update(video_params)
            flash[:success] = "Video information was successfully updated"
            redirect_to videos_path
        else
            render 'edit'
        end
    end

    def quiz_submit
        @video = Video.find(params[:id])
        @quiz = Quiz.find(params[:quiz_id])
        @questions = @quiz.questions
        @user = User.find(current_user.id)
        @qanswers = []
        if params[:Question]
            params[:Question].each do | q, a |
                @qanswers.push(a)
            end
        end
        
        
        if @qanswers.count == @questions.count
            puts @qanswers
            flash[:success] = "You rocked that quiz!! #{@qanswers.count} questions answered."
            redirect_to dashboard_path
        else
            flash[:danger] = "You didnt answer all the questions."
            @alittlehelp = true
            redirect_to video_path(@video)
        end

        
    
        
    end


    def destroy
        @video = Video.find(params[:id])
        @video.destroy
        flash[:danger] = "Video information has been deleted"
        redirect_to videos_path
    end

    


	private

        def video_params
            params.require(:video).permit(:name, :url, category_ids: [], quiz_ids:[], question_ids:[], answer_ids:[])
        end

        def set_video
            @video = Video.find(params[:id])
        end

        def is_admin?
        	if !current_user.admin
        		flash[:danger] = "Only admins can perform that operation"
        		redirect_to root_path
        	end
        end

        def quiz_answers
            if params[:Question]
                params[:Question][:id].to_a
            end
        end

end