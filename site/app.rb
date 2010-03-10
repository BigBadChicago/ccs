begin
  require ::File.expand_path("../.bundle/environment", __FILE__)
rescue LoadError
  require 'bundler'
  require 'rubygems'
  Bundler.setup
end

#
# Configuration
#

use Rack::Reloader
use Rack::CommonLogger
use Rack::ShowExceptions

configure :development do
  s = Session.create(:title => "Alt.NET", :description => "Learn everything about the Alt.NET and the community surrounding the movement.")
  s = Session.create(:title => "All.NET")
  s = Session.create(:title => "Not.NET")
  puts "Added #{Session.count()} session(s)."
  
  s = Speaker.create(:handle => "spereira", :full_name => "Sergio Pereira", :biography => "Sergio is an avid JavaScripter and runs the Chicago Alt.NET developer group.")
  s = Speaker.create(:handle => "sseely", :full_name => "Scott Seely", :biography => "Scott is a frequent speaker and author on all things .NET. He also runs the LCNUG in Grayslake, IL.")
  s = Speaker.create(:handle => "just3ws", :full_name => "Michael D. Hall")
  puts "Added #{Speaker.count()} speaker(s)."
end

#
# Models
#

class Speaker < Sequel::Model  
end

class Session < Sequel::Model
end




# 
# Home
#

get '/?' do
	@title = build_title "Home"
  haml :index
end

end

#
# Misc
#

get '/css/application.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :style
end

#
# Migrations
#

set :database, 'sqlite://ccs.db'

puts "The speakers table doesn't exist." if !database.table_exists?("speakers")
puts "The sessions table doesn't exist." if !database.table_exists?("sessions")

migration "create sessions table" do
  database.create_table :sessions do
    primary_key :id
    String :title, :null => false
    String :description
  end
end

migration "create speakers table" do
  database.create_table :speakers do
    primary_key :id
    String :handle, :null => false
    String :full_name, :null => false
    String :biography
  end
end
