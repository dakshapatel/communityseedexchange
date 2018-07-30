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

  get '/seeds' do
    erb :'/seeds/seeds'
  end

  get '/user_login' do
    if session[:user_id]
      redirect to '/seeds'
    else
      erb :welcome
  end
end

post '/login' do
  @user = User.gind_by(:username => params[:username])
  if @user != nil && authenticate(params[:password])
    session[:user_id] = @user.id
    redirect to 'seeds/seeds'
  else
    puts "please try again"
    redirect to '/welcome'
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
