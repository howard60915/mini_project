class Category < ApplicationRecord
	has_many :topic_categoryships
	has_many :topic_id , :through => :topic_categoryships
end
