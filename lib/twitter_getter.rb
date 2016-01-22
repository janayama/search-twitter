require_dependency 'twitter'
module TwitterGetter
	def get_tweets(category)
 		config_app = Rails.application.config_for :config

  	client = Twitter::REST::Client.new do |config|
		  config.consumer_key        = config_app['Twitter']['consumer_key']
		  config.consumer_secret     = config_app['Twitter']['consumer_secret']
		  config.access_token        = config_app['Twitter']['access_token']
		  config.access_token_secret = config_app['Twitter']['access_token_secret']
		end

		client.search(category, result_type: "recent").take(50)
  end
end
