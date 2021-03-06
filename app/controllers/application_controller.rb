require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  use Rack::Flash
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"

  end

  get '/' do
    erb :homepage
  end

  get '/logout' do
    if session[:user_id]
      session.clear
    end
    redirect to '/'
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    def authenticate_user
      if !logged_in?
        flash[:message] = "Please log in."
        redirect "/"
      end
    end
  end

end
