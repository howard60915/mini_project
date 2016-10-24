class Tag < ApplicationRecord

	has_many :topic_tagships, :dependent => :destroy
	has_many :topics , :through => :topic_tagships
end
