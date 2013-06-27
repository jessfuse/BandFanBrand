require 'twitter'

Twitter.configure do |config|
	config.consumer_key = ""
	config.consumer_secret = ""
	config.oauth_token = ""
	config.oauth_token_secret = ""
end

# Array for Handles 
tweeter_array_1 = []

# Array for Locations
@MasterBlaster = {}

# Use search to find handles
Twitter.search("#Chromatics", :lang => "en", :count => 10).results.each do |tweet|
   tweeter_array_1.push(tweet.from_user) 
end

# Find Twitter followers of an artist
Twitter.followers("mrshaasha").each do |person|
	if @MasterBlaster.has_key?(person.screen_name)
  		
  	else 
  		@MasterBlaster[screen_name] = person.location
  	end 
end

# Find location based on handle
tweeter_array_1.each do |handle|
	if @MasterBlaster.has_key?(handle)
  		
  	else 
  		@MasterBlaster[handle] = Twitter.user(handle).location.downcase!
  	end
end

puts @MasterBlaster



