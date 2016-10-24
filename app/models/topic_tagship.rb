class TopicTagship < ApplicationRecord
	belongs_to :topic
	belongs_to :tag
end
