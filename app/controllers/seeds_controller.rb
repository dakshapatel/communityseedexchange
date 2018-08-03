require 'pry'
class SeedsController < ApplicationController
  before '/seeds*' do
    authenticate_user
  end
#index, lists all seeds
  get '/seeds' do
    session[:user_id]
    @seeds = Seed.all
    
    erb :'/seeds/seeds'
  end


#new, should present a form for new seeds
  get '/seeds/new' do
    authenticate_user
    #create seed
    #list my seeds
   
    erb :"seeds/create_seeds"
  end

#create, should add a new seed to my application
  post '/seeds' do
    @user = User.find_by(session[:user_id])
    @seed = Seed.create(:name => params[:name], :catergory => params[:catergory], :description => params[:description], :user_id => @user.id)
    redirect to "/myseeds"
  end

  get '/myseeds' do
    erb :'seeds/myseeds'
  end 

  #show, show a particular seed based on ID
  get '/seeds/:id' do
    if session[:user_id]
      @seed = Seed.find_by(params[:id])
      erb :'seeds/myseeds'
    else
      redirect to '/'
    end
  end


#edit, should present a form to edit 
  get '/seeds/:id/edit' do
    @seed = Seed.find_by(params[:id])
    erb :'seeds/edit_seeds'
  end
#update, should update seed 1
  patch '/seeds/:id' do
    @seed = Seed.find_by_id(params[:id])
    @seed.name = params[:name]
    @seed.save
    redirect to "/seeds/#{@seed.id}"
  end

#destroy, should delete seed 1
  delete '/seeds/:id/delete' do
    @seed = Seed.find_by_id(params[:id])
    @seed.delete

    redirect to '/seeds'
  end


end
