class ApplicationController < ActionController::Base
    
    before_action :configure_permitted_parameters, if: :devise_controller?
    
    before_action :set_current_user
    
    before_action :authenticate_user!,except: [:top, :about]

    def set_current_user
        @current_user = User.find_by(id: session[:user_id])
    end
    
    def after_sign_in_path_for(resource) #ログインした後どこに飛ぶ
         books_path #ここ
    end
    
    protected
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys:[:name])
    end
end
