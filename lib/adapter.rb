class TweetIOAdapter
	attr_reader :last_tweet, :tweets, :string, :position

	def initialize(tweets)
		@tweets = tweets
		@last_tweet = @tweets[0]
		@string = ""
		@position = 0
	end

	def tweet_to_string(tweet)
		@temp = tweet.user[:screen_name] 
		@temp << " => "
		@temp << tweet.attrs[:text]
		@temp
	end

	def getc

	end

	def eof?

	end
end
