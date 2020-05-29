require 'tty-prompt'
require 'tty-spinner'
require 'tty-progressbar'
require 'pastel'
require 'tty-box'
require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
# require_relative '../lib/user.rb'
require_all 'lib'
ActiveRecord::Base.logger = nil