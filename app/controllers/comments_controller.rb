class CommentsController < ApplicationController
	before_action :set_comment
	

	def index
		@comments = @topic.comment.all
	end

	def show
		@comment = @topic.comment.find(params[:id])
	end	

	def new
		@comment = @topic.comment.build
	end

	def create
		@comment = @topic.comment.build(comment_params)
		@comment.save
	end







	private

	def set_comment
		@topic = Topic.find(params[:topic_id])
	end

	def comment_params
		params.require(:comment).permit(:content, :topic_id, :user_id)
	end
end
