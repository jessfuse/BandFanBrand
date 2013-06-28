require 'twitter'
require 'json'
require 'open-uri'

Twitter.configure do |config|
	config.consumer_key = ""
	config.consumer_secret = ""
	config.oauth_token = ""
	config.oauth_token_secret = ""
end

# Array for Handles 
tweeter_array_1 = []

# Array for Locations
@MasterBlaster = []

#User Input Dialogue
puts "What band or album do you want to look for?"
@search_term = "#" + gets.chomp!
puts "Cool. What is the Twitter handle of the band?"
@search_handle = gets.chomp!
puts "Cool.  Wait a second for the results."
# puts @search_term
# puts @search_handle

# Use search to find handles
Twitter.search("#{@search_term}", :lang => "en", :count => 10).results.each do |tweet|
   tweeter_array_1.push(tweet.from_user) 
end

# Google Locator 
def google_locater(location)
  address_from_user = "#{location}"
  uri = "https://maps.googleapis.com/maps/api/geocode/json?address=#{address_from_user.gsub(' ', '%20')}&sensor=false"
  response = open(uri).read
  return JSON.parse(response)["results"][0]["formatted_address"]
end

# Find Twitter followers of an artist
Twitter.followers("#{@search_handle}").each do |guy|
  location_entry = google_locater(guy.location)
  @MasterBlaster << {:user_name => guy.screen_name, :location => location_entry}
end

# Find location based on handle
tweeter_array_1.each do |handle|
  location_entry = google_locater("#{Twitter.user(handle).location}")
  @MasterBlaster << { :user_name => handle, :location => location_entry }
end

puts @MasterBlaster



