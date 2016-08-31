#list of all questions
get '/questions' do
  @questions = Question.all
  erb :'questions/index'
end

#new question form
get '/questions/new' do
  erb :'questions/new'
end

#create new question
post '/questions' do
  @question = Question.new(title: params[:question][:title], author: current_user,
  body: params[:question][:body])

  if @question.save
    redirect "/questions/#{@question.id}"
  else
    @errors = user.errors.full_messages
    erb :'questions/new'
  end

end

# #question details
# before '/questions/:id' do
#   pass if request.path_info.match /new/
#   # @question = find_and_ensure_entry(params[:id])
# end

get '/questions/:id' do
  @question = Question.find_by(id: params[:id])
  erb :'questions/details'
end

get '/questions/:id/edit' do
end

put '/questions/:id' do
end


#create new answer for a question
get '/questions/:id/answers/new' do
end

post '/questions/:id/answers' do
end

get '/questions/:id/answers/:answer_id/edit' do
end

put '/questions/:id/answers/:answer_id' do
end

#create new comment for a question
get '/questions/:id/comments/new' do
end

post '/questions/:id/comments' do
end

#create new comment for an answer
get '/questions/:id/answers/:answer_id/comments/new' do
end

post '/questions/:id/answers/answer_id/comments' do
end
