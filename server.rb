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
	athletes_list = db.execute("select * from athletes;")
	erb :athletes, locals: { athletes: athletes_list }
end

get '/athletes/:id' do
	id = params[:id].to_i
	one_athlete = db.execute("select * from athletes where id = ?;", id)
	erb :show, locals: {athlete: one_athlete[0]}
end

post '/athletes' do 
	db.execute("insert into athletes (name, sport) values (?, ?);", params[:new_athlete], params[:new_sport])
	redirect('/athletes')
end

put '/athletes/:id' do
	id = params[:id].to_i
	edit_name = params[:edit_name]
	edit_sport = params[:edit_sport]
	db.execute("update athletes set name = ?, sport = ? where id = ?;", edit_name, edit_sport, id)
	redirect("/athletes")
end

delete '/athletes/:id' do 
	id = params[:id].to_i
	db.execute("delete from athletes where id = ?;", id)
	redirect('/athletes')
end







