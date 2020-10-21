FactoryBot.define do
  factory :notification do
    user { FactoryBot.create(:user) }
    recipient { FactoryBot.create(:user, username: "jdoe") }
    notified_of { FactoryBot.create(:comment) }
    action { Notification::COMMENTED }
  end
end
