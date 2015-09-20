FactoryGirl.define do
  factory :product do
    sequence(:name) { |n| "Product ##{n}" }
    sequence(:description) { |n| "Product description ##{n}" }
    photo { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'rails.png')) }
  end
end
