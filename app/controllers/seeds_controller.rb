class SeedsController < ApplicationController
  before '/seeds*' do
    authenticate_user
  end
#check
  get '/seeds' do
    session[:user_id]
    @seeds = Seed.all
    erb :'/seeds/seeds'
  end
#check
  get '/myseeds' do
    authenticate_user
    @seeds = current_user.seeds
    erb :"seeds/myseeds"
  end

  post '/seeds' do
    @user = User.find_by(session[:user_id])
    @seed = Seed.create(:name => params[:name], :catergory => params[:catergory], :description => params[:description], :user_id => @user.id)
    redirect to "/seeds/#{@seed.id}"
  end

  get '/seeds/:id' do
    if session[:user_id]
      @seed = Seed.find_by_id(params[:id])
      erb :'seeds/show_seeds'
    else
      redirect to '/'
    end
  end

  get '/seeds/:id/edit' do
    @seed = Seed.find_by(params[:id])
    erb :'seeds/edit_seeds'
  end

  patch '/seeds/:id' do
    @seed = Seed.find_by_id(params[:id])
    @seed.name = params[:name]
    @seed.save
    redirect to "/seeds/#{@seed.id}"
  end

  delete '/seeds/:id/delete' do
    @seed = Seed.find_by_id(params[:id])
    @seed.delete

    redirect to '/seeds'
  end


end
