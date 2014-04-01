class HomeController < ApplicationController

	def index
		@user = User.find_by_id(session[:user_id])
		if @user
			redirect_to entry_path
		else
			redirect_to sessions_new_path
		end
	end

	def entry

	end

end