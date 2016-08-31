#new user form
get '/users/new' do
  erb :'users/new'
end

#create the new user
post '/users' do
  user = User.new(params[:user])
  if user.save
    redirect '/'
  else
    @errors = user.errors.full_messages
    erb :'users/new'
  end
end

#list of users

get '/users' do
end
