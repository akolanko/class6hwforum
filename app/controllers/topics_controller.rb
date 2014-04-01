class TopicsController < ApplicationController

	def all
		@topics = Topic.all
	end

	def index
		@user =	User.find(params[:user_id])
		@topic = Topic.new
	end

	def show
		@topic = Topic.find(params[:id])
		@user = User.find(session[:user_id])
		@reply = Reply.new
	end

	def new
		@topic = Topic.new
		@user = User.find(params[:user_id])
	end

	def create
		@topic = Topic.create(topic_params)
		@topic.user_id = params[:user_id]
		if @topic.save

			redirect_to user_topic_path(@topic.user, @topic.id)
		else
			flash[:alert] = "There was a problem submitting your post."
			redirect_to :back
		end
	end

	def edit

	end

	def update

	end

	def destroy
		@topic = Topic.where(id: params[:id]).first
		if @topic && @topic.destroy
			flash[:notice] = "Your post was deleted successfully."
			redirect_to user_topics_path(@topic.user) 
		else
			flash[:alert] = "There was a problem deleting your post."
			redirect_to :back
		end
	end

private
	
	def topic_params
		params.require(:topic).permit(:title, :body)
	end

end