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
		@timeline = Twitter.user_timeline("myappleguy")
		@test = "myappleguy => @peacedaisies wait, wha? What would you use that for?"
	end
	
	before(:each) do
		@tweet_adapter = TweetIOAdapter.new(@timeline)
	end
	
	it "should initialize with a twitter user timeline" do
		@tweet_adapter.tweets.should == @timeline
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

	describe "#getc" do
		before(:each) do
			@tweet_adapter = TweetIOAdapter.new(@timeline)
		end

		it "should return the char at the current position" do
			@tweet_adapter.getc.should == @tweet_adapter.string[@tweet_adapter.position - 1]
		end

		it "should increment the position by one when called" do
			expect { @tweet_adapter.getc }.to change { @tweet_adapter.position }.by(1)
		end

		it "should raise eof error if position is greater or eq to string length" do
			@tweet_adapter.position = @tweet_adapter.string.length
			expect { @tweet_adapter.getc }.to raise_error(EOFError)
		end
	end
	
	describe "#eof?" do
		before(:each) do
			@tweet_adapter = TweetIOAdapter.new(@timeline)
		end

		it "should retrun true if position is not < string.length" do
			@tweet_adapter.position = @tweet_adapter.string.length
			@tweet_adapter.eof?.should == true
		end

		it "should return fasle is position is < sting.length" do
			@tweet_adapter.eof?.should == false
		end
	end
end

