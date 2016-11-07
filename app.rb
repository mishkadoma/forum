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

	@db. execute 'CREATE TABLE IF NOT EXISTS Comments
	(
	"id" INTEGER PRIMARY KEY AUTOINCREMENT,
	"created_date" DATE,
	"content" TEXT,
	"post_id" INTEGER
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


get '/details/:post_id' do
		post_id = params[:post_id]

		results = @db.execute 'select * from posts where id = ?', [post_id]
		@row = results[0]
		erb :details
	end

post '/details/:post_id' do
	post_id = params[:post_id]

	message = params[:message]

	@db.execute 'insert into comments
	(content, created_date, post_id)
	values (?, datetime(), ?)',
	[message, post_id]


	redirect to('/details/' + post_id)
end
