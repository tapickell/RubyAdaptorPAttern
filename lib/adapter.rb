require "twits.rb"

class TweetIOAdapter
	attr_reader :last_tweet, :tweets, :string
	attr_accessor :position

	def initialize(tweets)
		@tweets = tweets
		@last_tweet = @tweets[0]
		@twits = TwitObjects.new
		@position = 0 
		tweets_to_twits(@tweets)
		@string = @twits.parse
	end


	def tweets_to_twits(tweets)
		tweets.each do |tweet|
			@twits << Twit.new(tweet)
		end
	end

	def getc
		raise EOFError unless @position < @string.length
		ch = @string[@position]
		@position += 1
		ch
	end

	def eof?
		@position >= @string.length
	end
end

