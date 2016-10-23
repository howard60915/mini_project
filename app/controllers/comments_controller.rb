class CommentsController < ApplicationController
	
	before_action :authenticate_user!
	before_action :set_comment
	

	def create
		@comment = @topic.comments.build(comment_params)
		@comment.user_id = current_user.id
		@comment.save

		respond_to do |format|
			format.html { redirect_to topic_path(params[:topic_id]) }
			format.js
		end	
		@topic.views -= 1
		@topic.save
	end

	def edit
		@comment = @topic.comments.find(params[:id])
	end

	def update
		@comment = @topic.comments.find(params[:id])
		if current_user == @comment.user &&@comment.update(comment_params)
			flash[:notice] = "編輯成功"
			redirect_to topic_path(params[:topic_id])
		else
			flash[:alert] = "編輯失敗"
			redirect_to topic_path(params[:topic_id])
		end
		if params[:remove_comment_file] == "1"
			@comment.logo = nil
		end	
		@topic.views -= 1
		@topic.save	
	end


	def destroy
		@comment = @topic.comments.find(params[:id])
		if current_user == @comment.user
			@comment.destroy
		end	
		respond_to do |format|
			format.html {redirect_to topic_path(@topic)}
			format.js
		end 	
		   
		   @topic.views -= 1
		   @topic.save

	end	









	private

	def set_comment
		@topic = Topic.find(params[:topic_id])
	end

	def comment_params
		params.require(:comment).permit(:content, :status ,:avatar , :topic_id, :user_id,:id)
	end
end
