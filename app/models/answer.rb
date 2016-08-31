class Answer < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  belongs_to :question
  has_many :comments, as: :commentable
  has_many :votes, as: :votable

  def chosen_answer?
    self.question.chosen_answer == self
  end

  def score
    self.votes.sum(:value)
  end

  validates :body, presence: true

end
