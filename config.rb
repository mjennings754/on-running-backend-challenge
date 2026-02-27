require 'sinatra'
require 'sinatra/activerecord'
require 'faraday'
require 'json'
require 'dotenv/load'
require 'rack/attack'

set :databse, ENV['DATABASE_URL']

use Rack::Attack

helpers do
    def authorized?
        request.env["HTTP_AUTHORIZATION"] == "Bearer #{ENV["AUTH_TOKEN"]}"
    end
end