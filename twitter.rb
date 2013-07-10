require 'twitter'
require 'json'
require 'open-uri'
require 'pry'

Twitter.configure do |config|
	config.consumer_key = "WGKsIyF1bIgyMzyOyfPlUw"
	config.consumer_secret = "opQAAE16rGBMhSN9RhHR2w3rbnLPku4G83kaKChyyI"
	config.oauth_token = "499825106-3OUNfxYMxxhXXlfVq4Nqx5aeSjwwhainYIbDkR5i"
	config.oauth_token_secret = "jlDv0dzbckoV1YT8LpqlvjAqozU6lFmXYKLOYDW8"
end

# Array for Handles 
tweeter_array_1 = []

# Array for Locations
@MasterBlaster = []

# Array for Markers
@markers = []

# Array for Newly Joined Markers
@new_markers = []

#User Input Dialogue
puts "What band or album do you want to look for?"
@search_term = "#" + gets.chomp!
puts "Cool.  Wait a second for the results."
# puts "What is the Twitter handle of the band?"
# @search_handle = gets.chomp!
# puts "Cool.  Wait a second for the results."
# puts @search_term
# puts @search_handle

# Use search to find handles
Twitter.search("#{@search_term}", :lang => "en", :count => 20).results.each do |tweet|
   tweeter_array_1.push(tweet.from_user) 
end

# Google Locator 
def google_locater(location)
  address_from_user = "#{location}"
  @usable_address = ""
  if address_from_user != ""
    @usable_address = address_from_user
  else
    @usable_address = "none"
  end
  uri = "https://maps.googleapis.com/maps/api/geocode/json?address=#{@usable_address.gsub(' ', '%20').gsub('ÜT:', '')}&sensor=false"
  response = open(uri).read
  parsed_response = JSON.parse(response)
  if parsed_response["results"].empty?
    return nil
  else
    final_address = parsed_response["results"][0]["formatted_address"]
    @markers.push(final_address)
    return final_address
  end
end


# Find Twitter followers of an artist
# Twitter.followers("#{@search_handle}").each do |guy|
#   location_entry = google_locater(guy.location)
#   @MasterBlaster << {:user_name => guy.screen_name, :location => location_entry}
# end

# Find location based on handle
tweeter_array_1.each do |handle|
  location_entry = google_locater("#{Twitter.user(handle).location}")
  @MasterBlaster << { :user_name => handle, :location => location_entry } if location_entry
end


#Add the %7 Separator to each Marker entry
@markers.each do |mark|
  this_marker = "|#{mark}"
  @new_markers << this_marker
end

#Joining the markers 
t = @new_markers.join('')

# The combined new URL
m = "http://maps.googleapis.com/maps/api/staticmap?center=Austin,TX&zoom=1&size=1200x600&markers=size:mid%7Ccolor:red#{t}&sensor=false"

# This opens the google map in an html file to be viewed in browser
File.open("googlemaps.html", 'w') do |f|
  f.write("<h3>Tweets that include #{@search_term} and #{@search_handle}'s followers.</h3>")
  f.write("<img src='#{m}' >")
end



