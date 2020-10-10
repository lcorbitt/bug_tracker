FactoryBot.define do
  factory :user do
    username { Faker::Internet.username }
    email { Faker::Internet.email }
    password { 'Password1' }
    role { :employee }

    trait :admin do
      role { :admin }
    end
  end
end
