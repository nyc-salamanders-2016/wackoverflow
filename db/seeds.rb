users = [
  {username: "pshawn", email: "shawn@email.com", password: "password"},
  {username: "schmoin", email: "moin@email.com", password: "password"},
  {username: "joshbosh", email: "josh@email.com", password: "password"}
]

shawn, moin, josh = *User.create!(users)

question = Question.create(author: shawn, title: "HAAALP", body: "THIS IS SO WACK I'M BEING CHASED BY A GIANT MALLET")

answers = [
  {question: question, author: josh, body: "Not the best answer"},
  {question: question, author: moin, body: "THE ULTIMATE ANSWER"}
]

Answer.create!(answers)

question.chosen_answer = Answer.find(2)
question.save

Comment.create(commentable: question, author: josh, body: "Tets test")
Vote.create(user: moin, votable: question, value: 1 )

users1 = []

70.times do
users1 << {username: Faker::Internet.user_name, email: Faker::Internet.free_email, password: Faker::Internet.password}
end

users1.each do |user|
  User.create!(user)
end 

User.all 


question1 = Question.create(author: User.all.sample, title: "huh?", body: "why does the sky cry rain?")
answers1 = [
  {question: question1, author:User.all.sample, body:"why does the earth shake when it's sad?"},
  {question: question1, author:User.all.sample, body:"your mom cries whenever I'm nice to her"},
  {question: question1, author:User.all.sample, body:"5"},
  {question: question1, author:User.all.sample, body:"huh"},
]

Answer.create!(answers1)

question1.chosen_answer = Answer.find(3)
question1.save

Comment.create!(commentable:question1,author: User.all.sample, body: "wow...")
Comment.create!(commentable:question1,author: User.all.sample, body: "hmm...")

question2 = Question.create(author: User.all.sample, title: "colors", body: "why color is the sky in argentina?")
answers2 = [
  {question: question2, author:User.all.sample, body:"what color is the sky?"},
  {question: question2, author:User.all.sample, body:"ocean"},
  {question: question2, author:User.all.sample, body:"black, it's night..."},
  {question: question2, author:User.all.sample, body:"porcupine"},
]

Answer.create!(answers2)

question2.chosen_answer = Answer.find(rand(3))
question2.save

Comment.create!(commentable:question2,author: User.all.sample, body: "wow...")
Comment.create!(commentable:question2,author: User.all.sample, body: "hmm...")

question3 = Question.create(author: User.all.sample, title: "What does the cow think", body: "of my jeans?")
answers3 = [
  {question: question3, author:User.all.sample, body:"who cares"},
  {question: question3, author:User.all.sample, body:"your mom thinks my jeans are medium"},
  {question: question3, author:User.all.sample, body:"vietnam"},
  {question: question3, author:User.all.sample, body:"think about it..."},
]

Answer.create!(answers3)

question3.chosen_answer = Answer.find(3)
question3.save

Comment.create!(commentable:question3,author: User.all.sample, body: "wow...")
Comment.create!(commentable:question3,author: User.all.sample, body: "hmm...")





values = [1,-1]

200.times do 
Vote.create(user: User.all.sample, votable: question1, value: values.sample)
end

200.times do
id = User.all.sample.id
Vote.create(user: User.all.sample, votable: Answer.all.sample, value: values.sample) unless Vote.find_by(user_id: id)
end

200.times do
id = User.all.sample.id
Vote.create(user: User.all.sample, votable: Comment.all.sample, value: values.sample) unless Vote.find_by(user_id: id)
end




