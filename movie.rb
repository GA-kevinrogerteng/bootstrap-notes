require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'

get '/' do
	
	erb :index
end

post '/results' do 
	
	search_str = params[:movie]
	# html_str = "<html><head><title>Movie Search Results</title></head><body><h1>Movie Results</h1>\n<ul>"
	response = Typhoeus.get("http://www.omdbapi.com/", :params => {:s => "#{search_str}"})
	result = JSON.parse(response.body)["Search"]
	@result = result.sort_by {|movie| movie["Year"]}
	erb :show

end

get '/poster/:imdb' do 
	picture = params[:imdb]
	response = Typhoeus.get("http://www.omdbapi.com/", :params => {:i => "#{picture}"})
  	result = JSON.parse(response.body)
  	@result = result
	erb :result
	
end
