require 'rubygems'
require 'bundler/setup'
Bundler.require(:default, ENV.fetch("ENV", "development"))

require 'dotenv/load'
Dir[File.dirname(__FILE__) + '/ruby/*.rb'].each {|file| require file }

