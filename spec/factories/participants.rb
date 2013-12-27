FactoryGirl.define do
  factory :participant do
    association :event
    sequence :default_name do |n|
      "person#{n}"
    end
  end
end
