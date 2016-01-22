class SearchController < ApplicationController
	include TwitterGetter
	include Cvs
	include CartoDB

  def index
  	render layout: "application"
  end

  def tweets
		category 	= params[:category]
		
		if (!category.present?)
			render json: "Missing parameter, category not found", status: 400 and return
		end

		tweets = get_tweets(category)
	
		header_csv = ['id', 'name', 'latitude', 'longitude','text']
		csv_string = json_to_csv(tweets, header_csv)
		path =  '/tmp/#{SecureRandom.urlsafe_base64}.csv'
    File.open(path, "w+") do |f|
    	f.write(csv_string)
		end

		item_id = import_file(path)
		details = get_details_item(item_id)
		
		render json: details, status: 200
  end
end