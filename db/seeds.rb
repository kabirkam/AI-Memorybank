require 'open-uri'

puts 'wiping db clean'
Note.destroy_all
User.destroy_all
Category.destroy_all
Reminder.destroy_all
User.destroy_all

puts 'creating fake users'
user1 = User.create(email: 'test1@test.com', password: 'testing')
user2 = User.create(email: 'test2@test.com', password: 'testing')

puts 'creating fake category'
category1 = Category.create!(name: "Work")
category2 = Category.create!(name: "Work")
category3 = Category.create!(name: "Work")
category4 = Category.create!(name: "Work")

puts 'creating fake notes'

sample_text = "Remember to call back Mum. She had mentioned in our last call that she was stressed about work because she couldn't find anyone to install the light fixture for a job. Also ask her how her friend Asma is doing."
note1 = Note.new(text: sample_text)
note1.user = user1
note1.category = category1
note1.audio.attach(
  filename: "test-audio1.mp3",
  io: URI.open('https://res.cloudinary.com/dojufit8k/video/upload/v1678122343/test-audio1_ixoswq.mp3')
)
note1.ai_images.attach(
  filename: "car1.jpg",
  io: URI.open('https://www.topgear.com/sites/default/files/news-listicle/image/jaguar_xj_r_sport_003.jpg?w=1654&h=930')
)
note1.ai_images.attach(
  filename: "car2.jpg",
  io: URI.open('https://www.topgear.com/sites/default/files/images/news-article/2023/03/49a03cbfd98de6806765a1f4867f734e/HARRIS%20YT%20THUMB%20VALK.jpg')
)
note1.save

note2 = Note.new(text: sample_text)
note2.user = user2
note2.category = category2
note2.audio.attach(
  filename: "test-audio1.mp3",
  io: URI.open('https://res.cloudinary.com/dojufit8k/video/upload/v1678122343/test-audio1_ixoswq.mp3')
)
note2.save

note3 = Note.new(text: sample_text)
note3.user = user2
note3.category = category3
note3.audio.attach(
  filename: "test-audio1.mp3",
  io: URI.open('https://res.cloudinary.com/dojufit8k/video/upload/v1678122343/test-audio1_ixoswq.mp3')
)
note3.save

note4 = Note.new(text: sample_text)
note4.user = user1
note4.category = category4
note4.audio.attach(
  filename: "test-audio1.mp3",
  io: URI.open('https://res.cloudinary.com/dojufit8k/video/upload/v1678122343/test-audio1_ixoswq.mp3')
)

note4.save
puts 'finished'
# File.new(URI.open('https://res.cloudinary.com/dojufit8k/video/upload/v1678122343/test-audio1_ixoswq.mp3'))
