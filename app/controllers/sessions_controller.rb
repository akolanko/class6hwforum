class SessionsController < ApplicationController

	def new

	end

	def create
		@user = User.where(email: params[:email]).first
		if @user && @user.password == params[:password]
			session[:user_id] = @user.id
			flash[:notice] = "Welcome #{@user.fname}!"
			redirect_to entry_path
		else
			flash[:alert] = "There was a problem logging you in."
			redirect_to sessions_new_path
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:notice] = "You have been logged out sucessfully."
		redirect_to sessions_new_path
	end

end