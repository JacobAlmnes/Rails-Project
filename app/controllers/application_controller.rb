class ApplicationController < ActionController::Base
    private

        def current_user
            @current_user ||= User.find(session[:user_id]) if session[:user_id]
        end

        def current_user?(user)
            current_user == user  
        end
        def require_signin
           session[:intended_route] = request.url
            unless current_user
                redirect_to new_session_url, alert: "Please sign in first!"
            end
        end
        def require_correct_user
            @user = User.find(params[:id])
            unless current_user?(@user)    
                redirect_to movies_path
            end
        end
        def require_admin
            unless current_user_admin?
              redirect_to root_url, alert: "Unauthorized access!"
            end
          end
          
          def current_user_admin?
            current_user && current_user.admin?
          end
    
        
        helper_method :current_user, :current_user?, :current_user_admin?
    

end