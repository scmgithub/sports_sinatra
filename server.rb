require 'sinatra'
require 'sqlite3'
require 'json'

db = SQLite3::Database.new "sports.db"

rows = db.execute <<-SQL
	create table if not exists athletes (
		id integer primary key,
		name text,
		sport text
		);
SQL

get '/' do 
	redirect('/athletes')
end

get '/athletes' do 
	athletes_list = db.execute("select * from athletes")
	erb :athletes, locals: { athletes: athletes_list }
end