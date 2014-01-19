FactoryGirl.define do
  factory :user do
    sequence :name do |n|
      "person#{n}"
    end
    email { "email_#{name}@example.com" }
    password 'qwerty12'
  end
end
