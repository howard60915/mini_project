class Topic < ApplicationRecord
	validates_presence_of :title
	belongs_to :user

	delegate :email, :to => :user , :prefix => true, :allow_nil => true
end
