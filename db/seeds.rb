puts 'wiping db clean'
User.destroy_all

puts 'creating fake records'

puts 'creating fake users'
user1 = User.create(email: 'test1@test.com', password: 'testing')
user2 = User.create(email: 'test2@test.com', password: 'testing')

# puts 'creating fake notes'
sample_text = "Remember to call back Mum. She had mentioned in our last call that she was stressed about work because she couldn't find anyone to install the light fixture for a job. Also ask her how her friend Asma is doing."
note1 = Note.create(text: sample_text)
car1.photo.attach(
  filename: "car1.jpg",
  io: URI.open('https://www.topgear.com/sites/default/files/news-listicle/image/jaguar_xj_r_sport_003.jpg?w=1654&h=930')
)
car1.save


puts 'finished'
