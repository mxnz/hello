FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "user##{n}" }
    sequence(:email) { |n| "user##{n}@abc.de" }
    sequence(:password) { |n| "password#{n}" }
  end

  factory :guest do
    sequence(:email) { |n| "guest##{n}@test.com" }
    sequence(:password) { |n| "password#{n}" }
  end

  factory :owner do
    sequence(:email) { |n| "owner##{n}@test.com" }
    sequence(:password) { |n| "password#{n}" }
    avatar { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'rails.png')) }
    sequence(:store) { |n| "store##{n}" }
  end

  factory :admin do
    sequence(:email) { |n| "admin##{n}@test.com" }
    sequence(:password) { |n| "password#{n}" }
    avatar { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'rails.png')) }
    sequence(:name) { |n| "admin##{n}" }
    sequence(:last_name) { |n| "nimda##{n}" }
    passport_photo { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'ruby.jpeg')) }
    birthdate { rand(20..40).years.ago }
  end
end
