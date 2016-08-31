post '/comments/:id/vote' do
  comment = Comment.find_by(id: params[:id])
  commentable = comment.commentable
  @question = (commentable.class == Question) ? commentable : commentable.question
  vote = Vote.new(votable: comment, value: params[:value], user: current_user)
  if vote.save
    redirect "/questions/#{@question.id}"
  else
    @errors = vote.errors.full_messages
    erb :'questions/details'
  end
end
