class UsersController < ApplicationController

    before_action :require_signin, except: [:new, :create]
    before_action :require_correct_user, only:[:edit, :destroy, :update]

    def index
        @users = User.all
    end

    def show
        @user = User.find(params[:id])
    end
    def new
        @user = User.new()
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to @user, notice: "Thanks for signing up!"
          else
            render :new
          end
    end

    def edit
        
    end
    
    def update
        
        if @user.update(user_params)
            redirect_to users_url
        else
            render :edit
        end
    end

    def destroy
        
        @user.destroy
        session[:user_id] = nil
        redirect_to users_url, alert: "Account successfully deleted!"
    end
end


private

def user_params
  params.require(:user).
    permit(:username, :name, :email, :password, :password_confirmation)
end