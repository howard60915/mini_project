class CommentsController < ApplicationController
	before_action :set_comment
	

	def create
		@comment = @topic.comments.build(comment_params)
		@comment.user_id = current_user.id
		if @comment.save
			flash[:notice] = "success to create"
			redirect_to topic_path(params[:topic_id])
		else
			@comment = @topic.comments.build
			flash[:alert] = "failed to create"
			redirect_to topic_path(params[:topic_id])
		end
	end
	def destroy
		@comment = @topic.comments.build(comment_params)
		@comment.destroy
		redirect_to topic_comments_path(@topic)
	end	









	private

	def set_comment
		@topic = Topic.find(params[:topic_id])
	end

	def comment_params
		params.require(:comment).permit(:content, :topic_id, :user_id,:id)
	end
end
