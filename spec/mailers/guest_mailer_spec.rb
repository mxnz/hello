require "rails_helper"

RSpec.describe GuestMailer, type: :mailer do
  let(:guest) { create(:guest) }
  let(:photo) { create(:photo) }

  describe '.photo_email' do
    before do
      GuestMailer.photo_email(photo, guest).deliver_now
      open_email(guest.email)
    end

    it 'it sends email with photo url to given guest' do
      expect(current_email).to have_link(photo[:title], href: photo[:url])
    end
  end
end
