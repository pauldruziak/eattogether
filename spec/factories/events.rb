FactoryGirl.define do
  factory :event do
    sequence :title do |n|
      "title#{n}"
    end
  end
end