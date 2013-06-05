require "twits.rb"
require "adapter.rb"
require "twitter"

describe Twit do
	before(:all) do
		Twitter.configure do |config|
			config.consumer_key = "E9cFBnHJOvAByaU8UBtSqg"
			config.consumer_secret = "HhBH46EdlUR0okDcP8178JzOjpeP7Dr4iMzPtUpH4"
			config.oauth_token = "243477652-XjDMaWdEJFon570spAL9m9hGBDBlcfxUZNjouHK5"
			config.oauth_token_secret = "prayHHQ0DblsMrzN8DZs9Lt0Oi2QxiGboILJphVVqA"
		end
		@timeline = Twitter.user_timeline("myappleguy")
		@test = "myappleguy => @peacedaisies wait, wha? What would you use that for?"
	end
  before(:each) do
		@tweet_adapter = TweetIOAdapter.new(@timeline)
		@tweet = @tweet_adapter.last_tweet
	  @twit = Twit.new(@tweet)
  end

	it "should initialize with a tweet and store the screen_name" do
		@twit.name.should ==  @tweet.user[:screen_name]
	end

	it "should initialize with a tweet and store the text" do
		@twit.text.should == @tweet.attrs[:text]
	end

	it "should respond to to_str" do
		@twit.should respond_to(:to_str)
	end

	describe "#to_str" do
		it "should return string of concat name and text" do
			@twit.to_str.should == "#{@twit.name} => #{@twit.text} "
		end
	end
end

describe TwitObjects do
	before(:all) do
		Twitter.configure do |config|
			config.consumer_key = "E9cFBnHJOvAByaU8UBtSqg"
			config.consumer_secret = "HhBH46EdlUR0okDcP8178JzOjpeP7Dr4iMzPtUpH4"
			config.oauth_token = "243477652-XjDMaWdEJFon570spAL9m9hGBDBlcfxUZNjouHK5"
			config.oauth_token_secret = "prayHHQ0DblsMrzN8DZs9Lt0Oi2QxiGboILJphVVqA"
		end
		@timeline = Twitter.user_timeline("myappleguy")
		@test = "myappleguy => @peacedaisies wait, wha? What would you use that for?"
	end
	before(:each) do
		@tweet_adapter = TweetIOAdapter.new(@timeline)
		@tweet = @tweet_adapter.last_tweet
		@twits = TwitObjects.new
	end
	
	it "should initialize with an empty array for subtwits" do
		@twits.sub_twits.should == []
	end

	describe "<<" do
		before(:each) do
			@tweet_adapter = TweetIOAdapter.new(@timeline)
			@tweet = @tweet_adapter.last_tweet
			@twits = TwitObjects.new
		end
		
		it "should add a twit to the sub_twits array" do
			@twits << :twit
			@twits.sub_twits.should == [:twit]
		end
	end

	describe "#parse" do
		before(:each) do
			@tweet_adapter = TweetIOAdapter.new(@timeline)
			@tweet = @tweet_adapter.last_tweet
			@twit = Twit.new(@tweet)
			@twits = TwitObjects.new
		end

		it "should return a string concat from parse call on each sub_twit" do
			@twits << @twit
			@twits << @twit
			@twits.parse.should == "#{@twit}#{@twit}"
		end
	end
end
