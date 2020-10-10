FactoryBot.define do
  factory :comment do
    user
    commented_on { FactoryBot.create(:ticket) }
    message { Faker::Hipster.sentences.join(' ') }
  end
end
