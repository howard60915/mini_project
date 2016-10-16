class CommentsController < ApplicationController
	
	before_action :authenticate_user!
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
		@topic.views -= 1
		@topic.save
	end

	def edit
		@comment = @topic.comments.find(params[:id])
	end

	def update
		@comment = @topic.comments.find(params[:id])
		if @comment.update(comment_params)
			flash[:notice] = "編輯成功"
			redirect_to topic_path(params[:topic_id])
		else
			flash[:alert] = "編輯失敗"
			redirect_to topic_path(params[:topic_id])
		end
		@topic.views -= 1
		@topic.save	
	end


	def destroy
		@user = current_user
		@comment = @topic.comments.find(params[:id])
		if @comment.destroy
		   flash[:alert] = "Comment Deleted"
		   redirect_to topic_path(@topic)
		   @topic.views -= 1
		   @topic.save
		else
			flash[:alert] = "Delete Failed "
			render topic_path(@topic)
		end	
	end	









	private

	def set_comment
		@topic = Topic.find(params[:topic_id])
	end

	def comment_params
		params.require(:comment).permit(:content, :status , :topic_id, :user_id,:id)
	end
end
