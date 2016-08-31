class Question < ActiveRecord::Base
  belong_to :author, class_name: 'user'
  has_one :chosen_answer, class_name: 'answer'
  has_many :answers
  has_many :comments, as: :commentable
  has_many :votes, as: :votable
end
