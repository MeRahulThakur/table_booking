class UsersController < ApplicationController

    def index
        @users = User.all
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:notice] = "Welcome to the Ping pong booking #{@user.name}, you have successfully signed up"
            redirect_to users_path
        else
            render 'new'
        end
    end

    private
      def user_params
        params.require(:user).permit(:name, :email, :password)
      end
end