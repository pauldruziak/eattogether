FactoryGirl.define do
  factory :family do
    sequence :name do |n|
      "name#{n}"
    end
    association :creator, factory: :user
    association :event, factory: :event
  end
end
