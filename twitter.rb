require 'twitter'

Twitter.configure do |config|
  config.consumer_key = ""
  config.consumer_secret = ""
  config.oauth_token = ""
  config.oauth_token_secret = ""
end

# Array for handles 
tweeter_array_1 = []

# Use search to find handles
Twitter.search("#Chromatics", :lang => "en", :count => 10).results.each do |tweet|
   tweeter_array_1.push(tweet.from_user) 
end

# # Find Twitter followers of an artist
Twitter.followers()

# # Find Twitter followers of an artist
Twitter.favoriters()

# # Find Twitter followers of an artist
Twitter.retweeters()

# # Find Twitter followers of an artist
Twitter.friendships()

# Find location based on handle
tweeter_array_1.each do |handle|
  puts Twitter.user(handle).location
end

