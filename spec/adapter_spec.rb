require "adapter.rb"
require "twitter"

describe TweetIOAdapter do
	before(:all) do
		Twitter.configure do |config|
			config.consumer_key = "E9cFBnHJOvAByaU8UBtSqg"
			config.consumer_secret = "HhBH46EdlUR0okDcP8178JzOjpeP7Dr4iMzPtUpH4"
			config.oauth_token = "243477652-XjDMaWdEJFon570spAL9m9hGBDBlcfxUZNjouHK5"
			config.oauth_token_secret = "prayHHQ0DblsMrzN8DZs9Lt0Oi2QxiGboILJphVVqA"
		end
	end
	
	before(:each) do
		@timeline = Twitter.user_timeline("myappleguy")
		@test = "myappleguy => @peacedaisies wait, wha? What would you use that for?"
		@tweet_adapter = TweetIOAdapter.new(@timeline)
	end
	
	it "should initialize with a twitter user timeline" do
		@tweet_adapter.tweets.should == @timeline
	end

	it "should store latest tweet object in variable" do
		@tweet_adapter.last_tweet.should == @timeline[0]
	end

	it "should initialize with an empty string" do
		@tweet_adapter.string.should == ""
	end

	it "should initialize with position set to 0" do
		@tweet_adapter.position.should == 0
	end

	it "should respond to getc" do
		@tweet_adapter.should respond_to(:getc)
	end

	it "should respond to eof?" do
		@tweet_adapter.should respond_to(:eof?)
	end

	describe "#tweet_to_string" do
		it "should return a string with user and full text" do
			@tweet_adapter.tweet_to_string(@tweet_adapter.last_tweet).should == @test
		end
	end
end
