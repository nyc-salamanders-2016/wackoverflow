#list of all questions
get '/questions' do
  @questions = Question.all
  erb :'questions/index'
end

#new question form
get '/questions/new' do
  erb :'questions/new' if current_user
end

#create new question
post '/questions' do
  @question = Question.new(title: params[:question][:title], author: current_user,
  body: params[:question][:body])

  if @question.save
    redirect "/questions/#{@question.id}"
  else
    @errors = @questions.errors.full_messages
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
  @question = Question.find(params[:id])
  erb :'answers/new'
end

post '/questions/:id/answers' do
  @question = Question.find(params[:id])
  @answer = Answer.new(author: current_user,
  body: params[:answer][:body], question: @question)

  if @answer.save
    redirect "/questions/#{@question.id}"
  else
    @errors = @answers.errors.full_messages
    erb :'answers/new'
  end

end

get '/questions/:id/answers/:answer_id/edit' do
end

put '/questions/:id/answers/:answer_id' do
end

#create new comment for a question
get '/questions/:id/comments/new' do
  @question = Question.find(params[:id])
  erb :'comments/new'
end

post '/questions/:id/comments' do
  @question = Question.find(params[:id])
  @answer
  @comment = Comment.new(author: current_user,
  body: params[:comment][:body], commentable: @question)

  if @comment.save
    redirect "/questions/#{@question.id}"
  else
    @errors = @answers.errors.full_messages
    erb :'answers/new'
  end
end

#create new comment for an answer
get '/answers/:answer_id/comments/new' do
  @answer = Answer.find(params[:answer_id])
  erb :'comments/new'
end

post '/answers/:answer_id/comments' do
  @answer = Answer.find(params[:answer_id])
  @question = @answer.question
  @comment = Comment.new(author: current_user,
  body: params[:comment][:body], commentable: @answer)
  if @comment.save
    redirect "/questions/#{@question.id}"
  else
    @errors = @comment.errors.full_messages
    erb :'comments/new'
  end
end
