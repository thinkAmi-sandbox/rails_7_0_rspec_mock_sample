class Api::Memorization::TweetsController < ApplicationController
  def index
    render json: { tweet: Api::External::Client.twitter.tweet }
  end

  def show
    render json: { retweet: Api::External::Client.twitter.retweet }
  end
end