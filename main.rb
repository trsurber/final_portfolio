require 'sinatra'
require 'sinatra/reloader' if development?

get "/" do
    @title = "Tricia Surber's Portfolio"
    @description = "This site showcases all of the work that Tricia Surber has done."
    @home = "active"
    erb :home
end

get "/about" do
    @title = "About Tricia Surber"
    @description = "This shows a little bit about Tricia Surber."
    @about = "active"
    erb :about
end

get "/example_work" do
    @title = "Example Work"
    @description = "These are examples of some of the work that Tricia Surber has done."
    @example_work = "active"
    erb :example_work
end

#https://dev.twitter.com
get "/tweets" do
    require 'twitter'
    OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
    client = Twitter::REST::Client.new do |config|
        config.consumer_key = "h7tlbn9qdyA15VcRQjU5vG1yW"
        config.consumer_secret = "fMl6MwHjVWQ6hO8mkvVjfbzMn6jZI4qcqsjUslOsIIcbQCYw7P"
        config.access_token = "567667222-H7bZoZ05SvV3q0NKYYM6f34EDg4V4warm5OH7iak"
        config.access_token_secret = "bDMsZqnmX6XTZYHIujTvOsajxRUfSwZCnXJzCqnXsbo3q"
    end
        @search_results = client.search("@supersurber13", result_type: "mixed").take(30).collect do |tweet|  
      #"#{tweet.user.screen_name}: #{tweet.text}"
        tweet
    end
    
    @title = "Tweets"
    @description = "Tweets from Tricia Surber."
    @tweets = "active"
    erb :tweets
end


get "/insta" do
    require "instagram"
    @title = "Instagram"
    @description = "Instagram Photos from Tricia Surber."
    @insta = "active"
    
    Instagram.configure do |config|
        config.client_id = "39d76c6f03754985a71b4011bc50a898"
        config.client_secret = "5384564b05b443fcb3e56193be7efee9"
    end
    
   client = Instagram.client(:access_token => session[:access_token])
  #html = "<h1>Search for users on instagram, by name or usernames</h1>"
  @photos = Array.new
  for photo in client.user_recent_media(339794862)
      @photos.push photo
    #for user in client.user_search("@tricia_surber")
      #html << "<li> <img src='#{user.profile_picture}'> #{user.username} #{user.full_name}</li>"
  end
  erb :insta
end





