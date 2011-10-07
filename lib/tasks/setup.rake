namespace :setup do
  namespace :load do
    desc "Load all the stuff!"
    task :all => :environment do
      bm = Benchmark.realtime {
        puts "rake:import:tracking:all"
        Rake::Task["setup:feeds:all"].invoke
        Rake::Task["setup:admin:all"].invoke
  #      Rake::Task["setup:categories:all"].invoke

      }
      puts "#{bm} seconds"
    end
  end

  namespace :feeds do
      desc "Create feed categories"
      task :all => :environment do
      bm = Benchmark.realtime {
        FeedCategory.create(:name => "Politics")
        FeedCategory.create(:name => "Sports")
        FeedCategory.create(:name => "Technology")
        FeedCategory.create(:name => "Science")
        FeedCategory.create(:name => "World")
        FeedCategory.create(:name => "Art&Design")
        FeedCategory.create(:name => "Entertainment")
        FeedCategory.create(:name => "Health")
        FeedCategory.create(:name => "Travel")
        FeedCategory.create(:name => "Business")
        FeedCategory.create(:name => "Finance")
        FeedCategory.create(:name => "US")

        }
        puts "#{bm} seconds"
      end
    end

  namespace :admin do
    desc "Create Admins"
    task :all => :environment do
    bm = Benchmark.realtime {
      User.create(:email => "admin@trendhop.com", :password => "Tr3ndh0P123", :password_confirmation => "Tr3ndh0P123", :first_name => "Sir", :last_name => "Admin", :city => "Adminville", :sex => "male", :role => "admin")
    }
      puts "#{bm} seconds"
    end
  end

end