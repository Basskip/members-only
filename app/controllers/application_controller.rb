class ApplicationController < ActionController::Base

    helper_method :logged_in?

    def current_user
        if (user_id = session[:user_id])
            @current_user ||= User.find_by(id: user_id)
        elsif (user_id = cookies.signed[:user_id])
            user = User.find_by(id: user_id)
            if user && user.remember_digest == Digest::SHA1.hexdigest(cookies[:remember_token])
                log_in user
                @current_user = user
            end
        end
    end

    def logged_in?
        !current_user.nil?
    end

    def log_in(user)
        session[:user_id]  = user.id
        user.create_remember_token
        remember(user)
    end

    def log_out
        forget(current_user)
        session.delete(:user_id)
        @current_user = nil
    end

    def remember(user)
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
    end

    def forget(user)
        cookies.delete :user_id
        cookies.delete :remember_token
    end
end