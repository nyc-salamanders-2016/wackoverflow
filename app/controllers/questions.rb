#list of all questions
get '/questions' do
  @questions = Question.all
  erb :'questions/index'
end

#new question form
get '/questions/new' do
  require_user
  erb :'questions/new'
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

post '/questions/:id/vote' do
  @question = Question.find_by(id: params[:id])
  vote = Vote.new(votable: @question, value: params[:value], user: current_user)
  if vote.save
    redirect "/questions/#{@question.id}"
  else
    @errors = vote.errors.full_messages
    erb :'questions/details'
  end
end

get '/questions/:id/edit' do
  require_user
  @question = Question.find_by(id: params[:id])
  erb :'questions/edit'
end

put '/questions/:id' do
end


#create new answer for a question
get '/questions/:id/answers/new' do
  require_user
  @question = Question.find_by(id: params[:id])
  erb :'answers/new'
end

post '/questions/:id/answers' do
  @question = Question.find_by(id: params[:id])
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
  require_user
  @question = Question.find_by(id: params[:id])
  erb :'comments/new'
end

post '/questions/:id/comments' do
 @question = Question.find_by(id: params[:id])
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
  require_user
  @answer = Answer.find_by(id: params[:answer_id])
  erb :'comments/new'
end

post '/answers/:answer_id/comments' do
  @answer = Answer.find_by(id: params[:answer_id])
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
