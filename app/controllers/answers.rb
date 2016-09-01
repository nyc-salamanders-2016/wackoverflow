post '/answers/:id/vote' do
  answer = Answer.find_by(id: params[:id])
  @question = answer.question
  vote = Vote.new(votable: answer, value: params[:value], user: current_user)
  if vote.save
    redirect redirect request.HTTP_REFERER
  else
    @errors = vote.errors.full_messages
    erb :'questions/details'
  end
end
