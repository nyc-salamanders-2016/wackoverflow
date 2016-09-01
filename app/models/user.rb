class User < ActiveRecord::Base
  has_many :answers, foreign_key: 'author_id'
  has_many :questions, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'author_id'

  has_secure_password

  validates :email, :username, presence: true
  validates :email, format: {with: /\A\w+@\w+[.]\w+\z/i, message: "must be valid email address."}
  validates :email, uniqueness: true
  validates :password, length: { minimum: 6 }

  def score
    (self.answers + self.questions + self.comments).reduce(0) {|sum, post| sum + post.score}
  end

  def rank
    case self.score
    when (-100...0)
      "Gallagher"
    when (0...10)
      "Whack-a-Mole"
    when (10...50)
      "Xzibit"
    else
      "Totally wack"
    end
  end

  def img
    case self.rank
    when "Gallagher"
      "https://weeklyworldnews.files.wordpress.com/2011/10/gallagherd.jpg"
    when "Whack-a-Mole"
      "http://indievideogames.com/wp-content/uploads/ninja-forms/icon_256-034.png"
    when "Xzibit"
      "https://cdn.meme.am/instances/500x/45075479.jpg"
    else
      "https://598d5fcf392acad97538-395e64798090ee0a3a571e8c148d44f2.ssl.cf1.rackcdn.com/9864517_the-address-at-wack-wack-scenic-living_tf8923e16.jpg"
    end
  end
end
