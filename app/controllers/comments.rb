post '/comments/:id/vote' do
  comment = Comment.find_by(id: params[:id])
  commentable = comment.commentable
  @question = (commentable.class == Question) ? commentable : commentable.question
  vote = Vote.new(votable: comment, value: params[:value], user: current_user)
  if vote.save
    if request.xhr?
      content_type :json
      {points: comment.score.to_s}.to_json
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

get '/comments/:id/edit' do
  require_user
  @comment = Comment.find_by(id: params[:id])
  @commentable = @comment.commentable
  @commentable = @commentable.question if @comment.commentable_type == "Answer"
  if current_user != @comment.author
    redirect "/questions/#{@commentable.id}"
  end
  erb :'comments/edit'
end

post '/comments/:id' do
  @comment = Comment.find_by(id: params[:id])
  @commentable = @comment.commentable
  @comment.update(body: params[:comment][:body])
  if @comment.save
    if @comment.commentable_type == "Question"
    redirect "/questions/#{@commentable.id}"
    else
    redirect "/questions/#{@commentable.question.id}"
    end
  else
    @errors = @comment.errors.full_messages
    erb :'comments/edit'
  end
end

delete '/comments/:id' do
  @comment = Comment.find_by(id: params[:id])
  @comment.destroy
  if @comment.commentable_type == "Question"
  redirect "/questions/#{@comment.commentable.id}"
  else
    redirect "/questions/#{@comment.commentable.question.id}"
  end
end

