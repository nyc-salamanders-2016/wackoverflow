#list of all questions
get '/questions' do
  @questions = Question.all
  erb :'questions/index'
end

#question details
get '/questions/:id' do
end

get '/questions/:id/edit' do
end

put '/questions/:id' do
end

#new question form
get '/questions/new' do
end

#create new question
post '/questions' do
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
