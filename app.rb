require 'sinatra'
require 'dotenv/load'
require 'airrecord'

set :protection, :except => :frame_options
set :bind, '0.0.0.0'

# When browser requests default page for domain, the path is '/'
# The most basic thing to do is return a string of HTML that the browser will display
get '/' do
  "<html><body><h1>Home Page</h1></body></html>"
end

# Ruby has lots of ways to make strings with variables interpolated into the string.
# ( FYI These are basic examples and for production apps you have to consider attack vectors)
get '/p1' do
  firstname = "John"
  lastname = "Doe"
  # This funny contruct in Ruby is called a HEREDDOC and lets you crerate multi-line strings easily
  html = <<-HTML
    <html>
      <body>
        Name: #{firstname} #{lastname}
      </body>
    </html>
  HTML
end

# Typically you will use HTML template languages to generate the HTML easier (like ERB/HAML/Slim)
get '/p2' do
  states = ['Cali', 'Nevada', 'Texas']
  html = <<-HTML
    <html>
      <body>
        <ul>
          <% states.each do |s| %>
            <li><%= s %></li>
          <% end %>
      </body>
    </html>
  HTML
  erb html, locals: {states: states}
end

# You usually split out templates into their own .html files, and just references them here in the code.
get '/mytemplate' do
  erb :index, locals: { host: request.host }
  # Ruby lets you do a lot of shortcuts to save typing and make things look nicer. 
  # The above line can also be written as 
  # erb(:index, {locals: {host: request.host}})
  # Or using the old Hash syntax ( the => is called a Hash rocket). Largely replaced by the new syntax which makes it look more like JSON/Javascript
  # erb(:index, {:locals => {:host => request.host}})
end

# Ruby web frameworks like Sinatra and Rails use Rack to handle the HTTP part of things. Rack expects an array of 3 elements, HTTP response code, a hash of HTTP headers, and a string of the content to return. Typically you dont need to know this, as the frameworks handle it all for you. 
get '/lowlevelbaby' do
  [200, {}, "Low Level"]
  # You could also say 
  # return [200, {}, "Low Level"]
  # But Ruby *always* returns the last thing to run, so you dont have to explicitly say it
end

# Show whats in the ENV var. Of course, NEVER DO THIS IN PROD! It will expose all your secrets :)
get '/env' do
  ENV.inspect
end

#
# AirTable Integration
#

Airrecord.api_key = ENV['AIRTABLE_API_KEY']

class SurfLocation < Airrecord::Table
  self.base_key = ENV['AIRTABLE_BASE_ID']
  self.table_name = "SurfLocations"
end


get '/surf_locations' do
  erb :surf_locations, {locals: {surf_locations: SurfLocation.all}}
end