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

		elsif params[:comment_time]#照回覆時間進行排序
			@topics = @topics.includes(:comments).order("comments.created_at DESC")

		elsif params[:comment_numbers]#照回覆數進行排序
			@topics = @topics.order("comments_count DESC")	
		end	

		if params[:default]
			@topics = @topics.all
		elsif params[:infernal]
			@category = Category.find(params[:infernal])
			@topics = @category.topics
		elsif params[:ocean]
			@category = Category.find(params[:ocean])
			@topics = @category.topics
		elsif params[:earth]
			@category = Category.find(params[:earth])
			@topics = @category.topics
		elsif params[:cloud]
			@category = Category.find(params[:cloud])
			@topics = @category.topics
		elsif params[:elder]
			@category = Category.find(params[:elder])
			@topics = @category.topics					
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

	def about
		@topics = Topic.all
		@user = current_user
		@comments = Comment.all
	end



	private

	def set_topic
		@topic = Topic.find(params[:id])
	end

	def topic_params
		params.require(:topic).permit(:title, :content ,:user_id, :comment_id, :category_ids =>[])
	end

end
