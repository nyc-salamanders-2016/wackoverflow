get '/answers/:answer_id/edit' do
  require_user
  @answer = Answer.find_by(id: params[:answer_id])
  @question = @answer.question
  if current_user != @answer.author
    redirect "/questions/#{@question.id}"
  end

  if request.xhr?
    erb :'answers/edit', layout: false
  else
    erb :'answers/edit'
  end
end

post '/answers/:answer_id' do
  @answer = Answer.find_by(id: params[:answer_id])
  @question = @answer.question
  @answer.update(body: params[:answer][:body])
  if @answer.save
    if request.xhr?
      "<p class='body-text'>#{@answer.body}</p>"
    else
      redirect "/questions/#{@question.id}"
    end
  else
    @errors = @answer.errors.full_messages
    erb :'answer/edit'
  end
end

#create new comment for an answer
get '/answers/:answer_id/comments/new' do
  require_user
  @answer = Answer.find_by(id: params[:answer_id])
  if request.xhr?
    erb :'comments/new', layout: false
  else
    erb :'comments/new'
  end
end

post '/answers/:answer_id/comments' do
  @answer = Answer.find_by(id: params[:answer_id])
  @question = @answer.question
  @comment = Comment.new(author: current_user,
  body: params[:comment][:body], commentable: @answer)
  if @comment.save
    if request.xhr?
      erb :'comments/_comment', layout: false, locals: {comment: @comment}
    else
      redirect "/questions/#{@question.id}"
    end
  else
    @errors = @comment.errors.full_messages
    erb :'comments/new'
  end
end

post '/answers/:id/vote' do
  answer = Answer.find_by(id: params[:id])
  @question = answer.question
  vote = Vote.new(votable: answer, value: params[:value], user: current_user)
  if vote.save
    if request.xhr?
      content_type :json
      {points: answer.score.to_s}.to_json
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


delete '/answers/:id' do
  @answer = Answer.find_by(id:params[:id])
  if @answer.author == current_user
    @answer.destroy
  end
  if request.xhr?
    ''
  else
    redirect "/questions/#{answer.question_id}"
  end
end

patch '/answers/:id' do
  @answer = Answer.find_by(id:params[:id])
  @question = @answer.question
  @question.chosen_answer = @answer
  @question.save
  puts "hi"
  redirect "/questions/#{@answer.question_id}"
end
