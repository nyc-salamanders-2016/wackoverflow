post '/comments/:id/vote' do
  comment = Comment.find_by(id: params[:id])
  commentable = comment.commentable
  @question = (commentable.class == Question) ? commentable : commentable.question
  vote = Vote.new(votable: comment, value: params[:value], user: current_user)
  if vote.save
    redirect request.HTTP_REFERER
  else
    @errors = vote.errors.full_messages
    erb :'questions/details'
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


