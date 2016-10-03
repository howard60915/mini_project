class Topic < ApplicationRecord
	validates_presence_of :title
	belongs_to :user
	has_many :comments

	delegate :email, :to => :user , :prefix => true, :allow_nil => true
end
