class SeedsController < ApplicationController

#check
  get '/seeds' do
     session[:user_id]
      @seeds = Seed.all
      erb :'seeds/seeds'
  end
#check
  get '/seeds/myseeds' do
     session[:user_id]
      erb :"seeds/create_seeds"
  end

  post '/seeds' do

      @user = User.find_by(session[:user_id])
      @seed = Seed.create(:name => params[:name], :user_id => @user.id)
    redirect to "/seeds/#{@seed.id}"

  end

  get '/seeds/:id' do
    if session[:user_id]
        @seed = Seed.find_by(params[:user_id])
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
          @seed.type = params[:type]
          @seed.description = params[:description]
          @seed.save
          redirect to "/seeds/#{@seed.id}"


    end

    post '/seeds/:id/delete' do
        @seed = Seed.find_by_id(params[:id])
        @seed.delete

        redirect to '/seeds/edit_seeds'
    end


end
