FactoryGirl.define do
  factory :order do
    user { create(:guest) }
    product
    url "http://remote_store/654321.png"
    thumbnail_url "http://remote_store/123456.png"
  end
end
