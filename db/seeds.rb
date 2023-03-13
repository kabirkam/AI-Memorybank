require 'open-uri'

puts 'wiping db clean'
Sentence.destroy_all
Reminder.destroy_all
Category.destroy_all
Note.destroy_all
User.destroy_all

puts 'creating fake users'
user1 = User.create!(email: 'test1@test.com', password: 'testing')
user2 = User.create!(email: 'test2@test.com', password: 'testing')

# puts 'creating fake category'
# category1 = Category.create!(name: "Work")

puts 'creating fake notes'

sample_text = "Remember to call back Mum. She had mentioned in our last call that she was stressed about work because she couldn't find anyone to install the light fixture for a job. Also ask her how her friend Asma is doing."
note1 = Note.new(text: sample_text)
note1.user = user1
note1.sentences.push(sample_text.split(/[,.]/).map { |sent| Sentence.new(text: sent) })
# note1.category = category1
note1.audio.attach(
  filename: "test-audio1.mp3",
  io: URI.open('https://res.cloudinary.com/dojufit8k/video/upload/v1678122343/test-audio1_ixoswq.mp3')
)
note1.sentences[0].ai_image.attach(
  filename: "car1.jpg",
  io: URI.open('https://www.topgear.com/sites/default/files/news-listicle/image/jaguar_xj_r_sport_003.jpg?w=256&h=256')
)
note1.sentences[1].ai_image.attach(
  filename: "car2.jpg",
  io: URI.open('https://www.topgear.com/sites/default/files/images/news-article/2023/03/49a03cbfd98de6806765a1f4867f734e/HARRIS%20YT%20THUMB%20VALK.jpg?w=256&h=256')
)
note1.sentences[2].ai_image.attach(
  filename: "car2.jpg",
  io: URI.open('https://www.topgear.com/sites/default/files/images/news-article/2023/03/dc3d2a65433234eefb8bb520057abc1a/2-Ferrari-Purosangue.jpg?w=256&h=256')
)
note1.save!

puts 'finished'
