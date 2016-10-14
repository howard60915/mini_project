class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :topics
  has_many :comments
  has_one :profile
  has_many :likes , :dependent => :destroy
  has_many :like_topics , :through => :likes , :source => :topic

  def short_name
	self.email.split("@").first        	
  end


         
end
