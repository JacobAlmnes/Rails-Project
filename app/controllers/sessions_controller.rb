class SessionsController < ApplicationController


    def create
        user = User.find_by(email: params[:email_or_username]) ||
                User.find_by(username: params[:email_or_username])
        
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to session[:intended_route], notice: "Welcome back, #{user.name}"
            session[:intended_route] =nil

        else
            flash.now[:alert] = "Invalid email/password"
            render "new"
        end
    end
    def destroy
        session[:user_id]= nil
        redirect_to movies_path, notice: "Signed out"
    end
    def new
    end
end
