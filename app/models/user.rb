class User < ActiveRecord::Base
  has_secure_password

  validates :email, :username, presence: true
  validates :email, format: {with: /\A\w+@\w+[.]\w+\z/i, message: "must be valid email address."}
  validates :email, uniqueness: true
  validates :password, length: { minimum: 6 }

  def score
    self.votes.sum(:value)
  end
end
