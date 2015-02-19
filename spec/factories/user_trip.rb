FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(8) }
    password_confirmation { password }
    provider { 'email'}
    uid { email }
  end

  factory :trip do
    user
    destination { Faker::Address.city }
    start_date { Faker::Date.forward(365) }
    end_date { start_date + rand(25) }
    comment { Faker::Lorem.sentence }
    tid { SecureRandom.uuid }
  end
end