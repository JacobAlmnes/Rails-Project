class SessionsController < ApplicationController


    def create
        user = User.find_by(email: params[:email])
        
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to user, notice: "Welcome back, #{user.name}"

        else
            flash.now[:alert] = "Invalid email/password"
            render "new"
        end
    end
    def destroy
        
    end
    def new
    end
end
