require 'rails_helper'

RSpec.describe AdminErrorPurchaseNotificationJob, type: :job do
  let!(:guest) { create(:guest) }
  let!(:admins) { create_list(:admin, 2) }

  describe '.perform' do
    before { AdminErrorPurchaseNotificationJob.perform_now(guest) }
    it "sends guests's email to all admins" do
      Admin.all.each do |admin|
        open_email(admin.email)
        expect(current_email).to have_content(guest.email)
      end
    end
  end
end
