namespace :db do
  desc "Migrations for all databases"
  task :multimigrate => :environment do
    City.all.each do |city|
      puts "Run migration for #{city.alias}"
      sh "cd #{Rails.root.to_s} && bundle exec rake db:migrate RAILS_ENV=#{city.name}" #if city.id == 1 || city.id == 2      
    end
  end
end