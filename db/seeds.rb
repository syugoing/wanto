x=1
100.times do |n|
  email = Faker::Internet.email
  password = "password"
  name = Faker::Pokemon.name
  uid = x
  x = x+1
  provider = "seed"
  User.create!(email: email,
               password: password,
               password_confirmation: password,
               name: name,
               uid: uid,
               provider: provider,
               )
end

a = 1
99.times do |n|
  content = Faker::Food.ingredient
  user_id = a
  a == a+1
  User.create!(content: content,
                user_id: user_id,
                )
end

b = 1
99.times do |n|
  content = Faker::Food.ingredient
  user_id = b
  topic_id = b
  b == b+1
  User.create!(content: content,
                user_id: user_id,
                topic_id: topic_id,
                )
end
