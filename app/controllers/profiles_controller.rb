class ProfilesController < ApplicationController


		def show
			@profile = current_user.profile
		end

		def new
			@profile = Profile.new
		end	

		def create
			@profile = Profile.new(profile_params)
			@profile.save
		end



		private

		def profile_params
			params.require(:profile).permit(:nickname, :bio , :user_id)
			
		end
end
