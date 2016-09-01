post '/comments/:id/vote' do
  require_user
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
