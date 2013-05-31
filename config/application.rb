require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/base'
require 'active_record'
require 'logger'
require 'squeel'
require 'erb'

dbconfig = YAML.load(ERB.new(File.read('config/database.yml')).result)
RACK_ENV ||= ENV["RACK_ENV"] || "development"
ActiveRecord::Base.establish_connection dbconfig[RACK_ENV]
Dir.mkdir('log') if !File.exists?('log') || !File.directory?('log')
ActiveRecord::Base.logger = Logger.new(File.open("log/#{RACK_ENV}.log", "a+"))

Dir['./config/*.rb', './app/*/*.rb', './lib/*.rb'].each{ |f| require f }