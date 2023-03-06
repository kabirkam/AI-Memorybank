puts 'wiping db clean'
User.destroy_all

puts 'creating fake records'

puts 'creating fake users'
user1 = User.create(email: 'test1@test.com', password: 'testing')
user2 = User.create(email: 'test2@test.com', password: 'testing')

# puts 'creating fake notes'
note1 = Note.create(text: "Remember to call back Mum. She had mentioned in our last call that she was stressed about work because she couldn't find anyone to install the light fixture for a job. Also ask her how her friend Asma is doing.")
note2 = Note.create(text: "Remember to call back Dad. She had mentioned in our last call that she was stressed about work because she couldn't find anyone to install the light fixture for a job. Also ask her how her friend Asma is doing.")
note3 = Note.create(text: "Remember to call back friend. She had mentioned in our last call that she was stressed about work because she couldn't find anyone to install the light fixture for a job. Also ask her how her friend Asma is doing.")

puts 'finished'
