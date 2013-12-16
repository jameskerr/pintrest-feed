require 'sinatra'
require 'sinatra/activerecord'
require './environments'
require 'httparty'
require 'json'
require 'active_support/core_ext/hash'

class Item < ActiveRecord::Base
	validates_uniqueness_of :guid
end

get "/" do
	@title = "Welcome"
	erb :"index"
end

get "/saved" do 
	@items = Item.all
	erb :"saved"
end

post "/pins" do
	@user = params[:user]
	@title = "Pin Feed: #{@user}"
	begin 
		response = HTTParty.get("http://www.pinterest.com/#{@user}/feed.rss")
		rss_hash = Hash.from_xml(response.to_s)
		@rss = JSON.pretty_generate(rss_hash)
		@feed = rss_hash["rss"]["channel"]
		@items = rss_hash["rss"]["channel"]["item"]
		erb :"pins"
	rescue
		erb :"not_found"
	end
end

post "/save" do
	@item = Item.new(params)
	if @item.save
		"0 - Item saved successfully"
	else
		"1 - Save failed"
	end
end

post "/delete" do 
	Item.destroy(params[:id])
	"0 - Item deleted"
end

helpers do
	def title
		if @title
			"#{@title}"
		else
			"Welcome"
		end
	end
	
	def h(text)
    	Rack::Utils.escape_html(text)
  	end
end

after do
        ActiveRecord::Base.clear_active_connections!
end