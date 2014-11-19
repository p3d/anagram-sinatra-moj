ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'
require_relative 'anagram.rb'

include Rack::Test::Methods

def app
  Sinatra::Application
end

describe "Anagram" do
  it "should return anagrams of a single word" do
    get '/crepitus'

    response = JSON.parse last_response.body
    ["cuprites","pictures","piecrust"].each do |expected_word|
      response['crepitus'].must_include expected_word
    end
  end

  it "should return anagrams of multiple words" do
    get '/crepitus,paste'

    response = JSON.parse last_response.body
    ["cuprites","pictures","piecrust"].each do |expected_word|
      response['crepitus'].must_include expected_word
    end

    ['pates','peats','septa','spate','tapes','tepas'].each do |expected_word|
      response['paste'].must_include expected_word
    end

  end

  it "should return an empty array for a word not found in the dictionary" do
    get '/sdfwehrtgegfg'

    response = JSON.parse last_response.body

    assert_equal response['sdfwehrtgegfg'], []
  end
end
