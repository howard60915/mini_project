class TopicsController < ApplicationController
	

	before_action :set_topic , :only => [:show, :edit , :update, :destroy]
	
	def index
		
		@user = current_user

		if params[:keyword]
			@topics = Topic.where( [ "title like ?", "%#{params[:keyword]}%" ] )
		else
			@topics = Topic.all
		end
		
		if params[:order]
			sort_by = (params[:order] == 'title') ? 'title' : 'id'
			@topics = @topics.order(sort_by)	
		elsif params[:comment_time]
			@topics = @topics.order("created_at DESC")
		elsif params[:comment_numbers]
			@topics = @topics.order("comments_count DESC")	
		end	
		@topics = @topics.page(params[:page]).per(5)

		

		if params[:id]
			@topic = Topic.find(params[:id])
		else
			@topic = Topic.new
		end	
	end

	def show
		@user = current_user
		if params[:id] && params[:comment_id]
			@comment = @topic.comments.find(params[:comment_id])
		else
			@comment = Comment.new
		end	
	end

	def new
		@topic = current_user.topics.new
	end

	def create
		@topic = current_user.topics.new(topic_params)
		@topics = Topic.page(params[:page]).per(5)
		if @topic.save
		   redirect_to topics_path
		else 
		   render :action => :index
		end   
	end

	def edit
	end

	def update
		
		@topics = Topic.page(params[:page]).per(5)
		if current_user.topics.update(topic_params)
			redirect_to topic_path(@topic)
		else
			render :action => :index
		end		
	end

	def destroy
		@topic.destroy

		redirect_to topics_path
	end



	private

	def set_topic
		@topic = Topic.find(params[:id])
	end

	def topic_params
		params.require(:topic).permit(:title, :content ,:user_id, :comment_id, :category_ids =>[])
	end

end
