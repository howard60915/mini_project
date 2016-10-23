class Topic < ApplicationRecord
	validates_presence_of :title
	belongs_to :user
	has_many :comments, :dependent => :destroy
	has_many :topic_categoryships, :dependent => :destroy
	has_many :categories , :through => :topic_categoryships
	has_many :likes , :dependent => :destroy
	has_many :like_users , :through => :likes , :source => :user
	has_many :subscribes , :dependent => :destroy
  	has_many :subscribe_users , :through => :subscribes , :source => :user

	delegate :email, :to => :user , :prefix => true, :allow_nil => true
	delegate :content, :to => :comment , :prefix => true, :allow_nil => true

	has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/blank.png"
  	validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/


	
end
