class UsersController < ApplicationController

	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
		@topic = Topic.new
	end

	def search
		@users = User.where(email: params[:query])
	end

	def new
		@user = User.new
	end

	def create
		@user = User.create(user_params)
		if @user.save
			session[:user_id] = @user.id
			flash[:notice] = "Your account was created sucessfully."
			redirect_to entry_path
		else
			flash[:alert] = "There was a problem signing you up."
			redirect_to :back
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.where(id: params[:id])
		if @user.update_attributes(user_params)
			flash[:notice] = "Your information was saved sucessfully."
			redirect_to user_path(@user.id)
		else
			flash[:alert] = "There was a problem updating your information."
			redirect_to :back
		end
	end

	def destroy
		@user = User.where(id: params[:id]).first
		if @user && @user.destroy
			session[:user_id] = nil
			flash[:notice] = "Your account was deleted successfully."
			redirect_to "/"
		else
			flash[:alert] = "There was a problem deleting your account."
			redirect_to :back
		end
	end

private

	def user_params
		params.require(:user).permit(:fname, :lname, :username, :email, :password)
	end


end
