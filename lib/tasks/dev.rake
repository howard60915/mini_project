namespace :dev do
	desc "TODO"
  	task :rebuild => ["db:reset" , :fake]
	task :fake => :environment do
	topic = Topic.first
			@user = User.create(:email => "howard@gmail.com" , :password => "12345678")
			15.times do 
				@topic = Topic.create( :title => Faker::Book.title ,:content => Faker::Hipster.paragraph, :user_id => @user.id)
				(5..10).to_a.sample.times do 
					comment = @topic.comments.create(:content => Faker::Pokemon.name, :user_id => @user.id)
					
				end
			end
	end
end