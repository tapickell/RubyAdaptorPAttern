class Twit
	attr_reader :name, :text

	def initialize(tweet)
		@name = tweet.user[:screen_name]
		@text = tweet.attrs[:text]
	end

	def to_str
		"#{@name} => #{@text} "
	end
	alias :to_s :to_str
end

class TwitObjects
	attr_accessor :sub_twits

	def initialize
		@sub_twits = []
	end

	def <<(twit)
		@sub_twits << twit
	end

	def parse
		@sub_twits.each_with_object("") do |twit, string|
			string << twit
		end
	end
end
