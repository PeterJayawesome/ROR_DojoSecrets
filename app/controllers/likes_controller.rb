class LikesController < ApplicationController
  def create
  	# binding.pry
    like = current_user.likes.find_by(secret_id:params[:secret_id])
    if not like
    	current_user.likes.create(secret_id:params[:secret_id])
    end
  	redirect_to "/secrets"
  end

  def destroy
  	like = current_user.likes.find_by(secret_id:params[:secret_id])
  	if like
  		like.delete
  	end
  	redirect_to "/secrets"
  end
end
