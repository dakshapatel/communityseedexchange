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
    @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
    session[:user_id] = @user.id
     redirect to '/seeds'
  end

  # get '/seeds' do
  #   erb :'/seeds'
  # end

  get '/users/login' do
    if session[:user_id]
      redirect to '/seeds'
    else
      erb :'users/login'
  end
end

post '/users/login' do
  @user = User.find_by(:username => params[:username])
  if @user != nil && @user.authenticate(params[:password])
    session[:user_id] = @user.id
    redirect to 'seeds'
  else
     "please try again"
    redirect to '/'
  end
end

get '/seeds' do
  if session[:user_id]
    @seeds = Seed.all
    erb :'seeds/seeds'
  else
    redirects to '/'
  end
end

get '/logout' do
  if session[:user_id]
    session.clear
    redirect to '/welcome'
  else
    redirect to 'welcome'
  end
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
