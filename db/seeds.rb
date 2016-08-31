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
