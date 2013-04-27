gemrc = File::expand_path("~/.gemrc")
if File::exists?(gemrc)
  require 'yaml'
  conf = File::open(gemrc) {|rcfile| YAML::load(rcfile) }
  (conf[:sources] || []).grep(/lrdesign.com/).each do |server|
    source server
  end
end
source 'http://rubygems.org'

gem 'rails', '3.2.12'
gem 'rack', '~> 1.4.0'

gem 'rake'
gem "haml-rails"
gem "mizugumo"
gem "will_paginate"
gem "populator"
gem "faker"
gem "mysql2", "~> 0.3.10"
gem "activerecord"
gem "lrd_view_tools", ">= 0.1.3"
gem "logical_tabs"
gem "awesome_nested_set"
gem 'devise'
gem 'authlogic'
gem "chronic"
gem "logical-insight"
gem 'dynamic_form'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'

  gem 'zurb-foundation', '~> 4.0.0'
  gem 'quiet_assets'
  gem 'turbo-sprockets-rails3'

end

group :development, :test do
  gem 'rspec'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'launchy'
  gem 'thin'
  gem 'selenium-webdriver'
  gem 'database_cleaner'
  gem 'rspec-steps'
  gem 'debugger'
end

group :test do
  gem 'simplecov', :platform => "ruby_19"
  gem 'simplecov-vim', :platform => "ruby_19"
  gem 'fuubar'
end

group :development do
  gem 'capistrano'
  gem 'capistrano-ext'
  gem 'annotate'
  gem 'lrd_dev_tools', ">= 0.1.3"
  gem 'unicorn-rails'
  gem 'pivotal-github'
end
