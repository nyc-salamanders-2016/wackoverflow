class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  has_many :votes, as: :votable
  belongs_to :author, class_name: 'User'

  validates :body, presence: true

  def score
    self.votes.sum(:value)
  end
end
