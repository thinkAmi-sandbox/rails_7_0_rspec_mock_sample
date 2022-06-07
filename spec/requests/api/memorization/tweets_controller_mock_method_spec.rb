require 'rails_helper'

RSpec.describe 'Api::Memorization::TweetsController', type: :request do
  let(:response_body) { JSON.parse(response.body) }

  describe '[ツイート]: GET /api/memorization/tweets' do
    before do
      # tweetメソッドを差し替え
      twitter = instance_double(Api::External::Twitter)
      allow(Api::External::Client).to receive(:twitter).and_return(twitter) # 差し替え
      allow(twitter).to receive(:tweet).and_return('hello')
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
      allow(Api::External::Client).to receive(:twitter).and_return(twitter) # 差し替え
      allow(twitter).to receive(:retweet).and_return('bye')
    end

    after do
      Api::External::Client.instance_variable_set('@twitter', nil)
    end

    it 'レスポンスが返ってくる' do
      get '/api/memorization/tweets/1'

      expect(response_body).to eq({ 'retweet' => 'bye' })
    end
  end
end