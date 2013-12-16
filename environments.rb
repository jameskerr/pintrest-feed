configure :production do 
    
db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/pintrest_feed_db')

ActiveRecord::Base.establish_connection(
    :adapter => 'postgresql',
    :host => db.host,
    :username => db.user,
    :password => db.password,
    :database => db.path[1..-1],
    :encoding => 'utf8'
)
end

configure :development do
	set :database, 'sqlite:///dev.db'
end