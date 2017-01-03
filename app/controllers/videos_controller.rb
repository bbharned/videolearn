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
        @answers = Answer.where(name: @qanswers)

        if (@qanswers.count != @questions.count)
            flash[:danger] = "You didnt answer all the questions."
            redirect_to video_path(@video)
        else 
            check_quiz(@answers)
        end
            # @answers.each do |answer|
            #     if !answer.correct
            #         @alittlehelp += 1
            #         # flash[:danger] = "Oops, you got something wrong"
            #     else
            #        #@alittlehelp
            #        # flash[:success] = "You rocked that quiz!!"
            #        # redirect_to (dashboard_path)
            #        # return 
            #     end
            #     if @alittlehelp != 0
            #        flash[:danger] = "Oops, you got something wrong"
            #     else
            #        flash[:success] = "You rocked that quiz!!"
            #        #redirect_to (dashboard_path)
            #     end
            # end
            # render 'show'
        #end
            
    
        

        # @qanswers = []
        # if params[:Question]
        #     params[:Question].each do | q, a |
        #         @qanswers.push(a)
        #     end
        # end
        
        # @answers = Answer.where(name: @qanswers)
        # @answers.each do |answer|
        #     if answer.correct
        #         flash[:success] = "You rocked that quiz!!"
        #         redirect_to dashboard_path
        #     end
        # end

        # if (@qanswers.count == @questions.count)
        #     puts @answers
        #     flash[:success] = "You rocked that quiz!!"
        #     redirect_to dashboard_path
        # else
        #     flash[:danger] = "You didnt answer all the questions."
        #     redirect_to video_path(@video)
        # end

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
            @qanswers = []
            if params[:Question]
                params[:Question][:id].to_a
                params[:Question].each do | q, a |
                    @qanswers.push(a)
                end
            end
        end

        def check_quiz(answers)
            @helpcount = 0
            answers.each do |answer|
                if !answer.correct
                    @helpcount += 1
                end
            end
            if @helpcount > 0
                flash[:danger] = "Oops, looks like you answered something wrong, please check your answers and try again."
                redirect_to video_path(@video)
                return @helpcount
            else
                flash[:success] = "You totally rocked that quiz!!"
                redirect_to dashboard_path
            end
        end

end