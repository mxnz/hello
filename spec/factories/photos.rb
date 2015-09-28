FactoryGirl.define do
  factory :photo, class: Hash do
    skip_create

    album_id       1
    id             2
    title          "reprehenderit est deserunt velit ipsam"
    url            "http://placehold.it/600/771796"
    thumbnail_url  "http://placehold.it/150/1ff9f6"

    initialize_with { attributes }
  end

  factory :wrong_photo, class: Hash do
    skip_create

    album_id       1
    id             2
    title          "reprehenderit est deserunt velit ipsam"
    url            "http://placehold.it/600/771796"
    thumbnail_url  "http://placehold.it/150/fff9f6"

    initialize_with { attributes }
  end
end
