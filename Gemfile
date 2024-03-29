source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.4'
# Use pg as the database for Active Record
gem 'pg', '~> 1.2', '>= 1.2.3'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# xlsx
gem 'rubyzip', '~> 2.3', '>= 2.3.2'
gem 'axlsx_rails', '~> 0.6.1'
gem 'axlsx', git: "https://github.com/randym/axlsx.git",
             ref: "c8ac844572b25fda358cc01d2104720c4c42f450"
gem 'roo', '~> 2.8', '>= 2.8.3'
gem 'roo-xls', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# pretty print Ruby objects to visualize their structure.
gem 'awesome_print', '~> 1.9', '>= 1.9.2'

# Use Pry as your rails console, exapmle: can use cd 、 ls ...
gem 'pry-rails', '~> 0.3.9'

# An XML toolkit for Ruby
gem 'rexml', '~> 3.2', '>= 3.2.5'

gem 'strip_attributes', '~> 1.11'
gem 'activerecord-import', '~> 1.1'
gem 'paranoia', '~> 2.1', '>= 2.1.5'

gem 'sidekiq', '~> 6.2', '>= 6.2.1'
gem 'sidekiq-scheduler', '~> 3.1'
gem 'sidekiq-limit_fetch', '~> 3.4'
gem 'sidekiq-grouping', '~> 1.0', '>= 1.0.10'

# qrcode
gem 'rqrcode', '~> 2.1'
gem 'barby', '~> 0.6.8'

# pdf
gem 'combine_pdf', '~> 1.0', '>= 1.0.21'
gem 'prawn', '~> 2.4'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 5.0', '>= 5.0.1'
  gem 'factory_bot_rails', '~> 6.2'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
