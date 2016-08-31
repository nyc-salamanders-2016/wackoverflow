class Question < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  belongs_to :chosen_answer, class_name: 'Answer'
  has_many :answers
  has_many :comments, as: :commentable
  has_many :votes, as: :votable

  validates :body,:title, presence: true
end
