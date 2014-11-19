require 'sinatra'
require 'sinatra/reloader' if development?
require 'json'

get '/' do
  'Add a word to the url and I will try to find some anagrams for you. E.g. /'
end

get '/:words' do
  content_type :json
  words = params[:words]
  
  anagrams(words).to_json
end

def anagrams(words)
  _anagrams = {}
  _words = words.split(/,/)
  @@dict ||= load_dictionary

  _words.each do |word|
    _anagrams[word] = @@dict[alphabetise(word)].reject{|w| w == word}
  end

  return _anagrams
end

def alphabetise(word)
  word.split(//).sort.join
end

def load_dictionary
  File.open('dictionary_processed', "rb") {|f| Marshal.load(f)}
end
