class AdminTodoNotificationJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    todo_id = nil
    3.times do
      begin
        Timeout::timeout(3) { todo_id = Rails.configuration.market.create_todo }
        break
      rescue Timeout::Error
      end
    end
    if todo_id.present?
      Admin.all.each do |admin|
        AdminMailer.todo_email(todo_id, admin).deliver_later
      end
    else
      Admin.all.each do |admin|
        AdminMailer.timeout_on_creating_todo_email(admin)
      end
    end
  end
end
