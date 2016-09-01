class Vote < ActiveRecord::Base
  belongs_to :votable, polymorphic: true
  belongs_to :user

  validates_uniqueness_of :user_id, scope: [:votable_id, :votable_type]
  validate :cannot_vote_on_own_stuff

  def cannot_vote_on_own_stuff
    if self.user == self.votable.author
      errors.add(:user, "Cannot upvote your own stuff")
    end
  end
end
