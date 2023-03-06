require 'open-uri'

puts 'wiping db clean'
User.destroy_all
Note.destroy_all
Category.destroy_all
Reminder.destroy_all

puts 'creating fake users'
user1 = User.create(email: 'test1@test.com', password: 'testing')
user2 = User.create(email: 'test2@test.com', password: 'testing')

puts 'creating fake notes'
sample_text = "Remember to call back Mum. She had mentioned in our last call that she was stressed about work because she couldn't find anyone to install the light fixture for a job. Also ask her how her friend Asma is doing."
note1 = Note.new(text: sample_text)
note1.user = user1
note1.audio.attach(
  filename: "test-audio1.mp3",
  io: URI.open('https://res.cloudinary.com/dojufit8k/video/upload/v1678122343/test-audio1_ixoswq.mp3')
)
note1.save

puts 'finished'
