class UsersController < ApplicationController

  get '/users/signup' do
    erb :'users/create_user'
  end

  post '/users/signup' do
    @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
    session[:user_id] = @user.id
    redirect to '/seeds'
  end

  get '/users/login' do
    if session[:user_id]
      redirect to '/seeds'
    else
      erb :homepage
    end
  end

  post '/users/login' do
    @user = User.find_by(:username => params[:username])
    if @user != nil && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/seeds'
    else

      authenticate_user = "Please try again."
      redirect to '/'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end
end




