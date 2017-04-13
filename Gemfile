source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails',            '~> 5.0.2'
gem 'pg',               '~> 0.18'
gem 'puma',             '~> 3.0'
gem 'sass-rails',       '~> 5.0'
gem 'uglifier',         '>= 1.3.0'
gem 'coffee-rails',     '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks',       '~> 5' # Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'jbuilder',         '~> 2.5' # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'devise',           '~> 4.2.0'
gem 'whenever',         '~> 0.9'
gem 'httparty',         '~> 0.10'
gem 'dotenv-rails',     '~> 2.2.0'

group :development do
  gem 'annotate',               '~> 2.7'
  gem 'web-console',            '>= 3.3.0'
  gem 'listen',                 '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen',  '~> 2.0.0'
  gem 'capistrano-bower',       '~> 1.1',  require: false
  gem 'capistrano',             '~> 3.4',  require: false
  gem 'capistrano-rvm',         '~> 0.1',  require: false
  gem 'capistrano-rails',       '~> 1.1',  require: false

  gem 'capistrano-git-submodule-strategy', require: false, git: 'https://github.com/ekho/capistrano-git-submodule-strategy.git'
end

group :development, :test do
  gem 'rspec-rails'
end

group :test do
  gem 'shoulda',            '~> 3.5'
  gem 'shoulda-matchers',   '~> 2.8.0', require: false
  gem 'vcr',                '~> 2.9'
  gem 'factory_girl_rails'
  gem 'webmock'
end
