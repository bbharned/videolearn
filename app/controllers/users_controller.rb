class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :show]
    

    def index
        @users = User.paginate(page: params[:page], per_page: 20).order(:lastname)
    end


    def new
        @user = User.new
    end

    def create

        @user = User.new(user_params)

        if @user.save
            flash[:success] = "Welcome to ThinManager Video Learning #{@user.firstname}"
            redirect_to dashboard_path
        else
            render 'new'
        end

    end

    def edit
        
    end

    def update
        if @user.update(user_params)
            flash[:success] = "Account information was successfully updated"
            redirect_to dashboard_path
        else
            render 'edit'
        end
    end

    def show
        
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        flash[:danger] = "User and user info has been deleted"
        redirect_to users_path
    end



    private

    def user_params
        params.require(:user).permit(:firstname, :lastname, :email, :email_confirmation, :company, :password, :password_confirmation)
    end

    def set_user
        @user = User.find(params[:id])
    end

   

end