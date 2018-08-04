require 'pry'
class SeedsController < ApplicationController
  before '/seeds*' do
    authenticate_user
  end

 
  get '/seeds' do
    session[:user_id]
    @seeds = Seed.all
    
    erb :'/seeds/index'
  end

  get '/seeds/new' do
    authenticate_user
    erb :"seeds/new"
  end

  post '/myseeds' do
    authenticate_user
    @user = User.find_by(session[:user_id])
    @seed = Seed.create(:name => params[:name], :catergory => params[:catergory], :description => params[:description], :user_id => @user.id)
    redirect to "/seeds/#{@seed.id}"
  end

  get '/users_seeds' do 
    @user = User.find_by(session[:user_id])
    
    @seed = Seed.create(:name => params[:name], :catergory => params[:catergory], :description => params[:description], :user_id => @user.id)
    erb :'/seeds/users_seeds'
  end 

  get '/seeds/:id' do
    @seed = Seed.find_by(params[:id])
    erb :'seeds/show'
  end

  get '/index' do
    @myseeds = Seed.find_by(params[:user_id])
    erb :'seeds/index'
  end 

  get '/seeds/:id/edit' do
    @seed = Seed.find_by(params[:id])
    erb :'seeds/edit'
  end

  patch '/seeds/:id/edit' do
    @seed = Seed.find_by_id(params[:id])
    @seed.name = params[:name]
    @seed.save
    redirect to "/seeds/#{@seed.id}"
  end

#destroy, should delete seed 1
  delete '/seeds/:id/delete' do
    @seed = Seed.find_by(params[:id])
    @seed.delete

    redirect to '/seeds'
  end


end
