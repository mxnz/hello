FactoryGirl.define do
  factory :photo, class: Market::Struct::Photo do
    skip_create

    album_id       1
    id             2
    title          "reprehenderit est deserunt velit ipsam"
    url            "http://placehold.it/600/771796"
    thumbnail_url  "http://placehold.it/150/1ff9f6"
  end

  factory :wrong_photo, class: Market::Struct::Photo do
    skip_create

    album_id       1
    id             2
    title          "reprehenderit est deserunt velit ipsam"
    url            "http://placehold.it/600/771796"
    thumbnail_url  "http://placehold.it/150/fff9f6"
  end
end
