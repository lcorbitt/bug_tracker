FactoryBot.define do
  factory :project do
    user
    name { Faker::Hipster.sentence }
    description { Faker::Hipster.sentences.join(' ') }
  end
end
