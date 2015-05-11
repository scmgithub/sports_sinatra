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

get '/athletes/:id' do
	id = params[:id].to_i
	one_athlete = db.execute("select * from athletes where id = ?;", id)
	erb :show, locals: {athlete: one_athlete[0]}
end

