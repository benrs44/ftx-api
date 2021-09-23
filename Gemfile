# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in ftx-api.gemspec
gemspec

group :test do
  gem 'simplecov', '< 0.18'
  gem 'httparty', '~> 0.19'
end

gem "rake", "~> 13.0"
gem "minitest", "~> 5.0"
gem "rubocop", "~> 1.7"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "pry-rails"
end