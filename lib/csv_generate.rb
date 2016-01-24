require 'csv'

class CsvGenerate
  def initialize
    @header_attr = ['id', 'name', 'latitude', 'longitude', 'text']
  end

  def convert_json(tweets)
  	CSV.generate(headers: true) do |csv|
      csv << @header_attr
      tweets.each do |tweet|
      	coordinates = get_location()
        csv << [tweet['user']['id'], tweet['user']['screen_name'], coordinates['latitude'], coordinates['longitude'], tweet['text']]
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

  def write(csv_string)
    path = "/tmp/#{SecureRandom.urlsafe_base64}.csv"
    File.open(path, "w+") do |f|
      f.write(csv_string)
    end
    return path
  end
end
