class PostController < ApplicationController
    before '/posts*' do
        authenticate_user
      end

    get '/post' do
        erb :'posts/new'
    end 

    get '/posts/new' do
        erb :'posts/new'
    end
    
    post '/posts' do
        @user = User.find_by(session[:user_id])
        @post = Post.create(:comments => params[:comments], :user_id => @user.id)
        redirect to "/seeds/user_seeds"
    end

    get '/post/:id' do
        @posts = Seed.find_by(params[:id])
        redirect to "/seeds/user_seeds"
      end

   
end 