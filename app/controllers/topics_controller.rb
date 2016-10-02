class TopicsController < ApplicationController
	

	before_action :set_topic , :only => [:show, :edit , :update, :destroy]
	
	def index
		@topics = Topic.page(params[:page]).per(5)
		@user = current_user
		if params[:id]
			@topic = Topic.find(params[:id])
		else
			@topic = Topic.new
		end	
	end

	def show
		@topic = Topic.find(params[:id])
	end

	def new
		@topic = current_user.topics.new
	end

	def create
		@topic = current_user.topics.new(topic_params)
		if @topic.save
		   redirect_to topics_path
		else 
		   render :action => :new
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
		params.require(:topic).permit(:title, :content ,:user_id)
	end

end
