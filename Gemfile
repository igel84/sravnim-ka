source 'http://rubygems.org'

gem 'rails', '3.1.1'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'yaml_db', git:'git://github.com/lostapathy/yaml_db.git'

gem 'sqlite3'
#gem 'mysql2'#, '> 0.3'

#gem 'subdomain-fu', :git => "git://github.com/mbleigh/subdomain-fu.git"

gem 'execjs'
gem 'therubyracer'
gem 'rake'
gem 'haml-rails'

gem 'sorcery'
gem 'roo'
gem 'kaminari'

gem 'ancestry'
gem 'acts_as_tree'

# Gems used only for assets and not required
# in production environments by default.
gem "twitter-bootstrap-rails", :group => :assets
group :assets do
  gem 'sass-rails',   '~> 3.1.4'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'jquery-fileupload-rails'
end

gem 'jquery-rails'
gem 'paperclip', :git => "git://github.com/thoughtbot/paperclip.git"
#gem "ckeditor", "3.6.3"
gem "ckeditor", "3.7.1"
gem 'friendly_id', "~> 4.0.1"

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end

group :test, :development do
  gem 'thin'
end

gem "rolify"