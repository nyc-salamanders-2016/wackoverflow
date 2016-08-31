class Answer < ActiveRecord::Base
  belong_to :author, class_name: 'user'
  belong_to :question
  has_many :comments, as: :commentable
  has_many :votes, as: :votable

  def chosen_answer?
    self.question.chosen_answer == self
  end
end
