require 'rails_helper'

RSpec.describe 'Api::Memorization::TweetsController', type: :request do
  let(:response_body) { JSON.parse(response.body) }

  describe '[ツイート]: GET /api/memorization/tweets' do
    before do
      # tweetメソッドを差し替え
      twitter = instance_double(Api::External::Twitter)
      allow(Api::External::Twitter).to receive(:new).and_return(twitter)
      allow(twitter).to receive(:tweet).and_return('hello')
    end

    after do
      Api::External::Client.remove_instance_variable('@twitter')
    end

    it 'レスポンスが返ってくる' do
      get '/api/memorization/tweets'

      expect(response_body).to eq({ 'tweet' => 'hello' })
    end
  end

  describe '[リツイート]: GET /api/memorization/tweets/1' do
    before do
      # retweetメソッドを差し替え
      twitter = instance_double(Api::External::Twitter)
      allow(Api::External::Twitter).to receive(:new).and_return(twitter)
      allow(twitter).to receive(:retweet).and_return('bye')
    end

    after do
      Api::External::Client.remove_instance_variable('@twitter')
    end

    it 'レスポンスが返ってくる' do
      get '/api/memorization/tweets/1'

      expect(response_body).to eq({ 'retweet' => 'bye' })
    end
  end
end