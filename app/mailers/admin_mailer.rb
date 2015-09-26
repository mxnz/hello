class AdminMailer < ApplicationMailer
  default from: 'delivery@example.com'
  layout 'admin_mailer'

  def todo_email(todo_id, admin)
    @todo_id = todo_id
    mail(to: admin.email, subject: 'Delivery Todo')
  end

  def error_on_purchase_email(guest, admin)
    @guest = guest
    mail(to: admin.email, subject: 'Error on purchase')
  end
end
