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

	@results = @db.execute 'select * from posts order by id desc'

	erb :index
end

get '/forum' do
	erb :forum
end

get '/send' do
	erb :send
end

post '/send' do
  message = params[:message]

	if message.strip.empty?
		@error = 'Введите сообщение'
		return erb :send
	end

	@db.execute 'insert into posts (content, created_date) values (?, datetime())', [message]
	redirect to ('/')

end
