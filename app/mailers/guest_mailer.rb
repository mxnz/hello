class GuestMailer < ApplicationMailer
  default from: 'delivery@example.com'
  layout 'guest_mailer'

  def photo_email(photo, guest)
    @photo = photo
    mail(to: guest.email, subject: 'Your Purchase')
  end
end
