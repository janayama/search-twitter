class SearchController < ApplicationController

  def index
  end

  def tweets
		category 	= params[:category]
		
		if (!category.present?)
			render json: "Missing parameter, category not found", status: 400 and return
		end

		tweets = TwitterGetter.new.get_tweets(category)

		csv = CsvGenerate.new			
		
		path = csv.write(csv.convert_json(tweets))

		cdb = CartoDB.new			

		item_id = cdb.import_file(path)
		details = cdb.get_details_item(item_id)
		
		render json: details, status: 200
  end
end