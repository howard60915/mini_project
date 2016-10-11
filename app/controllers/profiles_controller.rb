class ProfilesController < ApplicationController
		before_action :find_user
		before_action :authenticate_user!, :except => [:show]
		def show
			@profile = @user.profile
			@profiletopics = @user.topics.page(params[:page_topic]).per(10)
			@profilecomment = @user.comments.page(params[:page_comment]).per(10)
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
			
				@profile = @user.profile
			
		end

		def update
			@profile = @user.profile
			if @profile.update(profile_params)
				redirect_to user_profile_path(@user)
			else
				flash[:alert] = "Edit Failed"
				render :action => :edit
			end	
		end



		private
		def find_user
			@user = User.find(params[:user_id])
		end

		def profile_params
			params.require(:profile).permit(:nickname, :bio)
			
		end
end
