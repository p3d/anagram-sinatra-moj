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
    response["crepitus"].must_include("cuprites")
    response["crepitus"].must_include("pictures")
    response["crepitus"].must_include("piecrust")
  end

  it "should return anagrams of multiple words" do
    get '/crepitus,paste'

    response = JSON.parse last_response.body
    response["crepitus"].must_include("cuprites")
    response["crepitus"].must_include("pictures")
    response["crepitus"].must_include("piecrust")

    response["paste"].must_include("pates")
    response["paste"].must_include("peats")
    response["paste"].must_include("septa")
    response["paste"].must_include("spate")
    response["paste"].must_include("tapes")
    response["paste"].must_include("tepas")

  end

  it "should return an empty array for a word not found in the dictionary" do
    get '/sdfwehrtgegfg'

    response = JSON.parse last_response.body

    assert_equal response['sdfwehrtgegfg'], []
  end
end
