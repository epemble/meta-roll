require 'rubygems'
require 'sinatra'
require Dir.pwd+'/main.rb'

root_dir = File.dirname(__FILE__)

set :environment, :development
set :root, root_dir
set :app_file, File.join(root_dir, 'main.rb')
disable :run

FileUtils.mkdir_p 'log' unless File.exists?('log')
log = File.new("log/sinatra.log", "a")
$stdout.reopen(log)
$stderr.reopen(log)

run Sinatra::Application
