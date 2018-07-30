class SeedsController < ApplicationController


  get '/seeds' do
    if session[:user_id]
      @seeds = Seed.all
      erb :'seeds/seeds'
    else
      redirects to '/'
    end
  end
  
  get '/seeds/new' do
    if session[:user_id]
      erb :"seeds/create_seeds"
    else
      redirect to '/'
    end
  end

  post '/seeds' do #create action
    if params[:name] == ""
      redirect to '/seeds/new'
    else
      @user = User.find_by(session[:user_id])
      @seed = Seed.create(:name => params[:name],:type =>params[:type],:description =>params[:description], :user_id => @user.id)
      redirect to "/seeds/#{@seed.id}"
    end
  end

  get '/seeds/:id' do
    if session[:user_id]
        @seed = Seed.find_by(params[:id])
        erb :'seeds/show_seed'
    else
        redirect to '/'
    end
  end

  get '/seeds/:id/edit' do
        if session[:user_id]
            @seed = Seed.find_by(params[:id])
            erb :'seeds/seed_tweet'
        else
            redirect to '/'
        end
    end

    patch '/seeds/:id' do
      @seed = Seed.find_by_id(params[:id])

        if params[:name] == ""
          redirect to "/seeds/#{@seed.id}/edit"
        else

          @seed.name = params[:name]
          @seed.save
          redirect to "/seeds/#{@seed.id}/edit"
        end

    end

    delete '/seeds/:id/delete' do
        @seed = Seed.find_by_id(params[:id])
        @seed.delete

        redirect to '/seeds'
    end


end
