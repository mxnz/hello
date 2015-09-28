class AdminErrorPurchaseNotificationJob < ActiveJob::Base
  queue_as :default

  def perform(guest)
    Admin.all.each do |admin|
      AdminMailer.error_on_purchase_email(guest, admin).deliver_later
    end
  end
end
