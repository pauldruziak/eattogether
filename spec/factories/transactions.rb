FactoryGirl.define do
  factory :transaction do
    amount { rand(100) }
    association :creator, factory: :user
    association :event
  end
end
