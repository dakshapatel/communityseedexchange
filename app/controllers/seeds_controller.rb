class SeedsController < ApplicationController

#allows seeds view to display all seeds
  get '/seeds' do
     session[:user_id]
      @seeds = Seed.all
      erb :'seeds/seeds'
  end

  get '/seeds/myseeds' do
     session[:user_id]
      erb :"seeds/create_seeds"
  end

  post '/seeds/new' do
    if params[:name] == ""
        redirect to '/seeds/new'
      else
      @user = User.find_by(session[:user_id])
      @seed = Seed.create(:name => params[:name],:type =>params[:type],:description =>params[:description], :user_id => @user.id)
    redirect to "/seeds/myseeds"
  end
  end
  #
  # get '/seeds/:id' do
  #   if session[:user_id]
  #       @seed = Seed.find_by(params[:user_id])
  #       erb :'seeds/myseeds'
  #   else
  #       redirect to '/'
  #   end
  # end

  get '/seeds/:id/edit' do
        if session[:user_id]
            @seed = Seed.find_by(params[:id])
            erb :'seeds/show_seeds'
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
          @seed.type = params[:type]
          @seed.description = params[:description]
          @seed.save
          redirect to "/seeds/#{@seed.id}/edit"
        end

    end

    post '/seeds/:id/delete' do
        @seed = Seed.find_by_id(params[:id])
        @seed.delete

        redirect to '/seeds/edit_seeds'
    end


end
