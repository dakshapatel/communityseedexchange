class PostController < ApplicationController
    before '/posts*' do
        authenticate_user
      end

    get '/posts/new' do
        erb :post
      end
    
    post '/posts' do
        @user = User.find_by(session[:user_id])
        @post = Post.create(params)
        binding.pry
    redirect to "/seeds/user_seeds"
    end 
        

    get '/posts:id' do
    
        erb :'posts/post'
      end 
   
end 