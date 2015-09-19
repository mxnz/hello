FactoryGirl.define do
  factory :product do
    sequence(:name) { |n| "Product ##{n}" }
    sequence(:description) { |n| "Product description ##{n}" }
    photo nil
  end
end
