require 'rails_helper'

RSpec.describe AdminTodoNotificationJob, type: :job do
  let(:photo) { build(:photo) }
  let(:todo_id) { 925 }
  let!(:admins) { create_list(:admin, 3) }

  before { Rails.configuration.market.set_todo_id(todo_id) }

  describe '.perform' do
    before { AdminTodoNotificationJob.perform_now }
    it 'should send emails with todo id to all admins' do
      admins.each do |admin|
        open_email(admin.email)
        expect(current_email).to have_content todo_id
      end
    end
  end
end
