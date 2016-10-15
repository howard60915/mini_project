class TopicsController < ApplicationController
	
	before_action :authenticate_user!, except: [:index,:show]
	before_action :set_topic , :only => [:edit , :destroy]

	
	def index
		
		@user = current_user


		if params[:keyword]
			@topics = Topic.where( [ "title like ?", "%#{params[:keyword]}%" ] )
		else
			@topics = Topic.all
		end

		@topics = @topics.page(params[:page]).per(5)

		if params[:order]
			sort_by = (params[:order] == 'title') ? 'title' : 'id'
			@topics = @topics.order(sort_by)

		elsif params[:comment_time]#照回覆時間進行排序
			@topics = @topics.includes(:comments).order("comments.created_at DESC")

		elsif params[:comment_numbers]#照回覆數進行排序
			@topics = @topics.order("comments_count DESC")
	
		elsif params[:views_number] 
			@topcis = @topics.order("views DESC")
		end	
		
		if params[:default]
			@topics = @topics.order("created_at DESC")
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
		
		
		

		if params[:id]
			@topic = Topic.find(params[:id])
		else
			@topic = Topic.new
		end	
		
	end

	def show		
		@topic = Topic.find(params[:id])		
		@topic.views += 1
		@topic.save
		@users = @topic.like_users
		@like = current_user.likes.find_by(:topic_id => params[:id])

		
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
			# UserMailer.notify_new_topic(current_user, @topic).deliver_now!
		   redirect_to topics_path
		else 
		   render :action => :index
		end   
	end

	def edit
	end

	def update
		
		@topic = current_user.topics.find(params[:id])

		if @topic.update(topic_params)
			redirect_to topic_path(@topic)
		else
			render :action => :index
		end		
	end

	def destroy
		@topic.destroy
		respond_to do |format|
			# format.html{
			# 	redirect_to topics_path		
			# }
			format.js
		end	
	end

	def about
		@topics = Topic.all
		@user = current_user
		@comments = Comment.all
	end

	def like
		@like = current_user.likes.build(:topic_id => params[:topic_id])
		if @like.save
			flash[:notice] = "#{current_user.short_name} likes this topic"	
		else
			flash[:alert] = "Failed to like"
		end	
		respond_to do |format|
			format.js
		end	
	end

	def unlike
		@like = current_user.likes.find_by_topic_id(params[:topic_id])
		if @like.destroy
			flash[:notice] = "#{current_user.short_name} does not likes this topic"
		else
			flash[:alert] = "Failed to unlike"
		end	
		@like = nil
		respond_to do |format|
			format.js
		end	
		
	end



	private

	def set_topic
		@topic = Topic.find(params[:id])
	end

	def topic_params
		params.require(:topic).permit(:title, :content ,:user_id, :comment_id, :category_ids =>[])
	end

end
