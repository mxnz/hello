# Preview all emails at http://localhost:3000/rails/mailers/admin_mailer
class AdminMailerPreview < ActionMailer::Preview
  def todo_email
    admin = FactoryGirl.build(:admin)
    todo_id = 100
    AdminMailer.todo_email(todo_id, admin)
  end
end
