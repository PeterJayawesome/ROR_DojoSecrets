class SessionsController < ApplicationController
    skip_before_action :require_login,only:[:new,:login]
    def new
        # render login page
    end
    
    def login
        user = User.find_by_email(params[:Email]).try(:authenticate,params[:Password])
        if user
            session[:user_id] = user.id
            redirect_to "/users/#{current_user.id}"
        else
            flash[:errors] = ["Invalid Combination"]
            redirect_to "/sessions/new"
        end
    end
    def destroy
        # Log User out
        # set session[:user_id] to null
        # redirect to login page
        session[:user_id] = nil
        redirect_to "/sessions/new"
    end
end