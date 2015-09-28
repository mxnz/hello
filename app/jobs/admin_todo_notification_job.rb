class AdminTodoNotificationJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    todo_id = Rails.configuration.market.create_todo
    Admin.all.each do |admin|
      AdminMailer.todo_email(todo_id, admin).deliver_later
    end
  end
end
