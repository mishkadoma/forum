#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'



get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>!!"
end

get '/forum' do
	erb :forum
end

get '/send' do
	erb :send
end

post '/send' do
  @message = params[:message]
	erb :send
end
