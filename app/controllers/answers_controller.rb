class AnswersController < ApplicationController
	before_action :require_user
	before_action :require_admin

	def index
		@answers = Answer.all
	end

	def new
		@answer = Answer.new
	end


	def create

	    @answer = Answer.new(answer_params)

	    if @answer.save
	        flash[:success] = "answer was sucessfully created"
	        redirect_to answers_path
	    else
	        render 'new'
	    end

	end


	def edit
		@answer = Answer.find(params[:id])
	end 


	def update
		@answer = Answer.find(params[:id])
		if @answer.update(answer_params)
			flash[:success] = "Answer name was successfully updated"
			redirect_to answers_path
		else
			render 'edit'
		end
	end


	def show
		@answer = Answer.find(params[:id])
	end


	def destroy
        @answer = Answer.find(params[:id])
        @answer.destroy
        flash[:danger] = "Answer has been deleted"
        redirect_to answers_path
    end




	private

	def answer_params
		params.require(:answer).permit(:name, :correct)
	end

	def require_admin
		if !logged_in? || (logged_in? && !current_user.admin?)
			flash[:danger] = "Only Admins can perform that action"
			redirect_to root_path
		end
	end

end