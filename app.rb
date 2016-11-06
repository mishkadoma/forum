#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def init_db
	@db = SQLite3::Database.new 'forum.db'
	@db.results_as_hash = true
end

before do
	init_db
end

configure do
	init_db
	@db. execute 'CREATE TABLE IF NOT EXISTS Posts
	(
	"id" INTEGER PRIMARY KEY AUTOINCREMENT,
	"created_date" DATE,
	"content" TEXT
	);'
end

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
	erb "Ваше сообщение: #{@message}"
end
