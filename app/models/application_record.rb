class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

	 def short_name
		self.email.split("@").first        	
	 end
end
