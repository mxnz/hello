require "rails_helper"

RSpec.describe AdminMailer, type: :mailer do
  let(:todo_id) { 943 }
  let(:admin) { create(:admin) }
  let(:guest) { create(:guest) }

  describe ".todo_email" do
    before do
      AdminMailer.todo_email(todo_id, admin).deliver_now
      open_email(admin.email)
    end
    it 'sends email with todo id to admin' do
      expect(current_email).to have_content todo_id
    end
  end

  describe ".error_on_purchase_email" do
    before do
      AdminMailer.error_on_purchase_email(guest, admin).deliver_now
      open_email(admin.email)
    end
    it 'sends email with guest email to admin' do
      expect(current_email).to have_content(guest.email)
    end
  end
end
