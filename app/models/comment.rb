class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  has_many :votes, as: :votable
  belong_to :author, class_name: 'user'
end
