require 'csv'
module Cvs
  def json_to_csv(tweets, attributes)
  	CSV.generate(headers: true) do |csv|
      csv << attributes
      tweets.each do |tweet|
      	coordinates = get_location()
        csv << [tweet.user.id, tweet.user.screen_name, coordinates['latitude'], coordinates['longitude'], tweet.text]
      end
    end
  end

  def get_location()
  	# OPS! If you are here you will probably be wondering why is this if twitter already
  	# gives the coordinates. Not in the Search API that I am using. For that I need to use the 
  	# Streaming and I have to require access to it, which I do not have. So this is a simulation of it.
  	#
  	# https://dev.twitter.com/streaming/sitestreams#applyingforaccess
  	#

	  latitude = rand(-90.000000000...90.000000000)
		longitude = rand(-180.000000000...180.000000000)

		{'latitude' => latitude, 'longitude' => longitude}
	end
end
