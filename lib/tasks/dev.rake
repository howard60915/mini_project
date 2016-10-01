namespace :dev do
	task :fake => :environment do
	topic = Topic.first
		20.times do 
			Topic.create( :title => Faker::Book.title )
		end
	end
end