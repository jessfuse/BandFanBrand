require 'twitter'
require 'json'
# require 'gmaps4rails'

Twitter.configure do |config|
	config.consumer_key = ""
	config.consumer_secret = ""
	config.oauth_token = ""
	config.oauth_token_secret = ""
end

# Array for Handles 
tweeter_array_1 = []

# Hash for Locations
@MasterBlaster = {}

#User Input Dialogue
puts "What band or album do you want to look for?"
@search_term = "#" + gets.chomp!
puts "Cool. What is the Twitter handle of the band?"
@search_handle = gets.chomp!
puts "Cool.  Wait a second for the results."
# puts @search_term
# puts @search_handle

# Use search to find handles
Twitter.search("#{@search_term}", :lang => "en", :count => 50).results.each do |tweet|
   tweeter_array_1.push(tweet.from_user) 
end

# Find Twitter followers of an artist
Twitter.followers("#{@search_handle}").each do |guy|
  @MasterBlaster[guy.screen_name] = guy.location.downcase!
end

# Find location based on handle
tweeter_array_1.each do |handle|
  	@MasterBlaster[handle] = Twitter.user(handle).location.downcase!
end

puts @MasterBlaster



