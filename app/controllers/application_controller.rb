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
    @user = User.create(params)
    session[:user_id] = @user.id
     redirect to '/seeds'
  end

  get '/user_login' do
    if session[:user_id]
      redirect to '/seeds'
    erb :user_login
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end
