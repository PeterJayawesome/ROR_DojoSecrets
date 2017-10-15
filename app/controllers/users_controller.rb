class UsersController < ApplicationController
  skip_before_action :require_login, only:[:new,:create,:create_params]
  def new

  end

  def show
  	@secrets = current_user.secrets
  end

  def edit

  end

  def create
  	user = User.new(create_params)
  	if user.save
  		redirect_to "/sessions/new"
  	else
  		flash[:errors] = user.errors.full_messages
  		redirect_to "/users/new"
  	end
  end

  def update
  	user = current_user
  	user.name = params[:Name]
  	user.email = params[:Email].downcase
  	if user.save
  		# binding.pry
  		return redirect_to "/users/#{session[:user_id]}"
  	else
  		flash[:errors] = user.errors.full_messages
  		redirect_to "/users/#{session[:user_id]}/edit"
  	end
  end

  def delete
  	# binding.pry
  	user = User.find(params[:id])
  	user.destroy
  	session[:user_id] = nil
  	redirect_to "/users/new"
  end

  private
  def create_params
  	params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
end
