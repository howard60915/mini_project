class Profile < ApplicationRecord
	
	belongs_to :user

	def short_name
		self.email.split("@").first        	
  	end
end
