FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "user##{n}" }
    sequence(:email) { |n| "user##{n}@abc.de" }
    sequence(:password) { |n| "password#{n}" }
  end
end
