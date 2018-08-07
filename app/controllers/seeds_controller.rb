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

  get '/seeds/user_seeds' do 
    session[:user_id]
    @seeds = current_user.seeds
    erb :'seeds/users_seeds'
  end 

  get '/seeds/new' do
    erb :"seeds/new"
  end

  post '/seeds' do
    @user = User.find_by(session[:user_id])
    @seed = Seed.create(:name => params[:name], :catergory => params[:catergory], :description => params[:description], :user_id => @user.id)
    redirect to "/seeds/user_seeds"
  end


  get '/seeds/:id' do
    @seed = Seed.find_by(params[:id])
    erb :'seeds/edit'
  end

  patch '/seeds/:id' do
    @seed = Seed.find_by_id(params[:id])
    @seed.name = params[:name]
    @seed.description = params[:description]
    @seed.save
    redirect to "/seeds/#{@seed.id}"
  end


  get '/seeds/:id' do
    @seed = Seed.find_by(params[:id])
    erb :'seeds/users_seeds'
  end
  
  get '/seeds/:id/edit' do
    @seed = Seed.find_by(params[:id])
    erb :'seeds/edit'
  end

  delete '/seeds/:id/delete' do
    @seed = Seed.find_by(params[:id])
    @seed.delete

    redirect to 'seeds/users_seeds'
  end

end
