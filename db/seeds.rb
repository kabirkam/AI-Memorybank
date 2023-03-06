puts 'wiping db clean'
User.destroy_all

puts 'creating fake records'

puts 'creating fake users'
user1 = User.create(email: 'test1@test.com', password: 'testing')
user2 = User.create(email: 'test2@test.com', password: 'testing')

# puts 'creating fake notes'
sample_text = "Remember to call back Mum. She had mentioned in our last call that she was stressed about work because she couldn't find anyone to install the light fixture for a job. Also ask her how her friend Asma is doing."
note1 = Note.create(text: sample_text)


puts 'finished'
