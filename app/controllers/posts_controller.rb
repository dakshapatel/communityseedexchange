class PostController < ApplicationController
    before '/posts*' do
        authenticate_user
      end

    get '/posts/new' do
        erb :'posts/new'
    end
    
    post '/posts' do
        
    @user = User.find_by(session[:user_id])
    @post = Post.create(:comments => params[:comments], :user_id => @user.id)
    redirect to '/seeds/users_seeds'
    end

   
end 