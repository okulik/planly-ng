require 'faker'

User.create([
  {
    id: 1, provider: 'email', uid: 'orest@nisdom.com',
    encrypted_password: '$2a$10$V76ndEJmgtxPkZ5l0GqxSeLGSylsRwn/bRGFoZq9M5DN34yx/.ELS',
    email: 'orest@nisdom.com',
    sign_in_count: 0
  }, {
    id: 2, provider: 'email', uid: 'okulik@gmail.com',
    encrypted_password: '$2a$10$V76ndEJmgtxPkZ5l0GqxSeLGSylsRwn/bRGFoZq9M5DN34yx/.ELS',
    email: 'okulik@gmail.com',
    sign_in_count: 0
  }
])

data = []
300.times do
  h = {
    destination: Faker::Address.city,
    start_date: Faker::Date.forward(365),
    comment: Faker::Lorem.sentence,
    user_id: rand(2) + 1
  }
  h[:end_date] = (h[:start_date] + rand(25)).to_s
  h[:start_date] = h[:start_date].to_s
  data << h
end
Trip.create(data)