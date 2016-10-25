class Api::TopicsController < Api::BaseController


	def index
		@users = User.all
		@topics = Topic.all

		render :json => { :users => @users.map{|u| u.api_info}, :topics => @topics.map{|t| t.api_info} }
	end

end	