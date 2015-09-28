# Preview all emails at http://localhost:3000/rails/mailers/guest_mailer
class GuestMailerPreview < ActionMailer::Preview
  def photo_email
    guest = FactoryGirl.build(:guest)
    photo = FactoryGirl.build(:photo)
    GuestMailer.photo_email(photo, guest)
  end
end
