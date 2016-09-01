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


get '/questions/:id' do
  @question = Question.find_by(id: params[:id])
  erb :'questions/details'
end

post '/questions/:id/vote' do
  @question = Question.find_by(id: params[:id])
  vote = Vote.new(votable: @question, value: params[:value], user: current_user)
  if vote.save
    if request.xhr?
      content_type :json
      {points: @question.score.to_s}.to_json
    else
      redirect URI(request.referer).path
    end
  else
    @errors = vote.errors.full_messages
    status 400
    if request.xhr?
      @errors.to_json
    else
      erb :'questions/details'
    end
  end
end

get '/questions/:id/edit' do
  require_user
  @question = Question.find_by(id: params[:id])
  if current_user != @question.author
    redirect "/questions/#{@question.id}"
  end
  erb :'questions/edit'

end

post '/questions/:id' do
  require_user
  @question = Question.find_by(id: params[:id])
  @question.update(title: params[:question][:title], body: params[:question][:body])
  if @question.save
    redirect "/questions/#{@question.id}"
  else
    @errors = @questions.errors.full_messages
    erb :'questions/edit'
  end
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

delete '/questions/:id' do
  require_user
  @question = Question.find_by(id: params[:id])
  @question.destroy
  redirect "/questions"
end
