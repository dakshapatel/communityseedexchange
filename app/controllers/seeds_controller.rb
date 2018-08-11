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
    @user = User.find(session[:user_id])
    @seed = @user.seeds.build(:name => params[:name], :catergory => params[:catergory], :description => params[:description])
    if @seed.save
      redirect to "/seeds/user_seeds"
    else
      flash[:message]= "Please enter the seed name."
      redirect to '/seeds/new'
    end
  end

  get '/seeds/:id' do
    @seed = Seed.find(params[:id])
    erb :'seeds/show'
  end

  get '/seeds/:id/edit' do
    if @seed=current_user.seeds.find_by_id(params[:id])
      erb :'seeds/edit'
    else
      redirect to "/seeds/user_seeds"
    end
  end

  patch '/seeds/:id' do
    if @seed=current_user.seeds.find_by_id(params[:id])
      @seed.name = params[:name]
      @seed.description = params[:description]
      @seed.save
      redirect to "/seeds/user_seeds"
    else
      flash[:message]= "This is not your seed."
      redirect to "/seeds/seeds"
    end
  end

  post '/seeds/:id/delete' do
    if @seed=current_user.seeds.find_by_id(params[:id])
      @seed.delete
      redirect to '/seeds/user_seeds'
    else
      flash[:message]= "This is not your seed."
      redirect to "/seeds/seeds"
    end
  end

end


