class SubscribesController < ApplicationController
	before_action :authenticate_user!
	before_action :set_topic

	def create
		@subscribe = current_user.subscribes.build(:topic_id => params[:topic_id])
		@subscribe.save
		respond_to do |format|
			format.html { redirect_to topic_path(@topic) }
			format.js
		end	

	end

	def destroy
		@subscribe = current_user.subscribes.find_by_topic_id(params[:topic_id])
		@subscribe.destroy
		@subscribe = nil
		respond_to do |format|
			format.html { redirect_to topic_path(@topic) }
			format.js
		end
	end

	private

	def set_topic
		@topic = Topic.find(params[:topic_id])
	end

	def subscribe_params
		params.require(:subscribe).permit(:user_id, :topic_id,:id)
	end

end
