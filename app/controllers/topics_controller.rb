class TopicsController < ApplicationController
	before_action :set_topic , :only => [:show, :edit , :update, :destroy]
	
	def index
		@topics = Topic.all
	end

	def show
		@topic = Topic.find(params[:id])
	end

	def new
		@topic = Topic.new
	end

	def create
		@topic = Topic.new(topic_params)
		@topic.user = current_user
		if @topic.save
		   redirect_to topics_path
		else 
		   render :action => :new
		end   
	end

	def edit
	end

	def update
		@user = current_user
		if @topic.update(topic_params)
			redirect_to topic_path(@topic)
		else
			render :action => :edit
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
