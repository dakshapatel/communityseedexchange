require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :welcome
  end

  get '/users/signup' do
    erb :'users/signup'
  end

  post '/users/signup' do
    erb :'users/signup'
  end



  post '/users/signup' do
    erb :seeds
  end



end
