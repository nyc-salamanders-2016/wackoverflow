get '/' do
  if current_user
    erb :'users/index'
  else
    erb :'index'
  end
end

post '/' do
  @username = params[:user][:username]
  @user  = User.find_by(username: @username)
  if @user && @user.authenticate(params[:user][:password])
    session[:user_id] = @user.id
    redirect '/'
  else
    @errors = ['Invalid username/password']
    erb :'/users/login'
  end
end
