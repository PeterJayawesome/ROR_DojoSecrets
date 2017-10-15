class SecretsController < ApplicationController
  def index
  	@secrets = Secret.all
  	@likes = Secret.includes(:likes).select("secrets.*").group("secrets.id").count(:likes)
  end

  def create
  	secret = Secret.new(content:params[:Content],user:current_user)
  	if secret.save
  		redirect_to "/users/#{current_user.id}"
  	else
  		flash[:errors] = secret.errors.full_messages
  		redirect_to "/users/#{current_user.id}"
  	end
  end

  def destroy
  	secret = Secret.find(params[:id])
  	if current_user.id == secret.user_id
  		secret.destroy
  	end
  	redirect_to "/users/#{current_user.id}"
  end
end
