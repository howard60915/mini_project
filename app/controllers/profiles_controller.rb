class ProfilesController < ApplicationController
		before_action :find_user 
		before_action :authenticate_user!, :except => [:show]
		
		def show
			# @profile = User.find_by_nickname(params[:nickname]).profile
			@profile = Profile.find_by_nickname!(params[:nickname])
			@profiletopics = @user.topics.page(params[:page_topic]).per(10)
			@profilecomment = @user.comments.includes(:topic).page(params[:page_comment]).per(10)
		end

		def new
			@profile = @user.build_profile
		end	

		def create
			@profile = @user.build_profile(profile_params)
			if @profile.save
				redirect_to user_profile_path(@user)
			else
				render :action => :edit
			end	
		end

		def edit
			@profile = current_user.profile
		end

		def update
			@profile = current_user.profile

			if @profile.update(profile_params)
				redirect_to user_profile_path(@user)
			else
				flash[:alert] = "Edit Failed"
				render :action => :edit
			end	
		end

		def likes
			@profile = @user.profile
			@profilelike = @user.like_topics.page(params[:page_like]).per(10)
		end

		def subscribes
			@user = User.includes(:subscribes).find(params[:user_id])
			@profile = @user.profile

			
		end



		private

		def find_user
			@user = User.find(params[:user_id])
		end

		def profile_params
			params.require(:profile).permit(:nickname, :bio)
			
		end
end
