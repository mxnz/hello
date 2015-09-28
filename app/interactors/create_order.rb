class CreateOrder
  include Interactor

  def call
    photo = nil
    Timeout::timeout(3) { photo = Rails.configuration.market.get_photo }
    color = photo[:url].split('/').last.to_i(16)
    thumbnail_color = photo[:thumbnail_url].split('/').last.to_i(16)
    context.order = Order.new(
      user: context.guest,
      product: context.product,
      url: photo[:url],
      thumbnail_url: photo[:thumbnail_url]
    )
    if color >= thumbnail_color
      context.order.save!
      GuestMailer.photo_email(photo, context.guest).deliver_later
      AdminTodoNotificationJob.perform_later
    else
      AdminErrorPurchaseNotificationJob.perform_later(context.guest)
      error_msg = 'Wrong color!'
      context.order.errors.add(:base, error_msg)
      context.fail!(message: error_msg)
    end
  end
end
