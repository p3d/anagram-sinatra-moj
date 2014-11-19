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
    single_word_response = {"crepitus" => ["cuprites","pictures","piecrust"]}
    single_word_response.to_json.must_equal last_response.body
  end

  it "should return anagrams of multiple words" do
    get '/crepitus,paste'
    multi_word_response = {"crepitus"=>["cuprites","pictures","piecrust"],"paste"=>["pates","peats","septa","spate","tapes","tepas"]}
    multi_word_response.to_json.must_equal last_response.body
  end

  it "should return an empty array for a word not found in the dictionary" do
    get '/sdfwehrtgegfg'
    nonsense_word_response = {"sdfwehrtgegfg"=>[]}
    nonsense_word_response.to_json.must_equal last_response.body
  end
end
