namespace :dev do
	desc "TODO"
  	task :rebuild => ["db:reset" , :fake]
	task :fake => :environment do
	topic = Topic.first
		15.times do 
			@topic = Topic.create( :title => Faker::Book.title ,:content => Faker::Hipster.paragraph)
			(5..10).to_a.sample.times do 
				comment = @topic.comments.create(:content => Faker::Pokemon.name)
				
			end
		end
	end
end