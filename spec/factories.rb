FactoryGirl.define do
  factory :user do |u|
    u.sequence(:email) { |n| "tester#{n}@example.com" }
    u.password "$2a$10$VQfQvJi70cDfsiS049h5juW33Mn12AEUc7BwJw32T2kKEU4P6VgZu"
  end

  factory :conversation do |c|
  end

  factory :listener do |l|
    l.association :user
    l.association :conversation
  end

  factory :message do |m|
    m.association :sender, factory: :user
    m.association :conversation

    m.sequence(:subject) { |n| "subject #{n}" }
    m.sequence(:body) { |n| "body #{n}" }
  end
end

