
get '/login' do
  if request.xhr?
    erb :'users/_login', layout: false
  else
    erb :'users/login'
  end
end


get '/logout' do
  session.clear
  redirect '/'
end
