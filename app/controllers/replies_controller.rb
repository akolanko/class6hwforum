class RepliesController < ApplicationController

	def index

	end

	def new
		@reply = Reply.new
		@topic = Topic.find(params[:topic_id])
		@user = User.find(params[:user_id])
	end

	def create
		@reply = Reply.create(reply_params)
		@reply.user_id = params[:user_id]
		@reply.topic_id = params[:topic_id]
		if @reply.save
			redirect_to user_topic_path(@reply.user_id, @reply.topic_id)
		else
			flash[:alert] = "There was a problem posting your reply."
			redirect_to :back
		end
	end

	def edit

	end

	def update

	end

	def destroy
		@author = User.where(id: params[:user_id]).first
		@reply = Reply.where(id: params[:id]).first
		if @reply && @reply.destroy
			flash[:notice] = "Your post was deleted successfully."
			redirect_to user_topic_path(@author.id, @reply.topic_id) 
		else
			flash[:alert] = "There was a problem deleting your post."
			redirect_to :back
		end
	end

private
	
	def reply_params
		params.require(:reply).permit(:body)
	end

end