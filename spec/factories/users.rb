FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    password { "password" }
    phone {"12345678"}
    bank_account {"12345678"}
  end

  factory :admin, class: User do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    password { "password" }
    phone {"12345678"}
    bank_account {"12345678"}
    role {"admin"}
  end
end