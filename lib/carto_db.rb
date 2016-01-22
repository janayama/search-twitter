require 'rest-client'
module CartoDB
  def initialize()
	   config_app = Rails.application.config_for :config
	   @user_name = config_app['CartoDB']['user_name']
	   @api_key = config_app['CartoDB']['api_key']
	   @version = config_app['CartoDB']['version']
	end

  def import_file(path)
  	response = RestClient.post "https://#{@user_name}.cartodb.com/api/v#{@version}/imports/?api_key=#{@api_key}", :content_guessing => 'true', :create_vis => 'true', :file => File.new(path, 'rb')
		json_response = JSON.parse(response)
		json_response['item_queue_id']
  end

  def get_details_item(item_id, attemps = 0)
  	response = RestClient.get "https://#{@user_name}.cartodb.com/api/v#{@version}/imports/#{item_id}?api_key=#{@api_key}"
  	code = response.code
		json_response = JSON.parse(response)
		visualization_id = json_response['visualization_id']
		
		if !visualization_id || code == 404
			#resource not found or visualization not ready
			# Wait 3 seconds * number of attemps so we do not do lots of request to the server
			
			attemps += 1
			wait_time =  2 * attemps 
			sleep(wait_time)

			return get_details_item(item_id, attemps)

		end
		response
  end
end