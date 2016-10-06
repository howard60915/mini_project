class Topic < ApplicationRecord
	validates_presence_of :title
	belongs_to :user
	has_many :comments
	has_many :topic_categoryships
	has_many :categories , :through => :topic_categoryships
	

	delegate :email, :to => :user , :prefix => true, :allow_nil => true
	delegate :content, :to => :comment , :prefix => true, :allow_nil => true
end
