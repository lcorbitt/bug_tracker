FactoryBot.define do
  factory :ticket do
    user
    project
    title { Faker::Hipster.sentence }
    description { Faker::Hipster.sentences.join(' ') }
  end
end
