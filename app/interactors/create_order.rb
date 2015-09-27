class CreateOrder
  include Interactor

  def call
    photo = Rails.configuration.market.get_photo
    color = photo[:url].split('/').last.to_i(16)
    thumbnail_color = photo[:thumbnail_url].split('/').last.to_i(16)
    if color >= thumbnail_color
      context.order = Order.create(
        user: context.guest,
        product: context.product,
        url: photo[:url],
        thumbnail_url: photo[:thumbnail_url]
      )
      GuestMailer.photo_email(photo, context.guest).deliver_later
      AdminTodoNotificationJob.perform_later
    else
      AdminErrorPurchaseNotificationJob.perform_later(context.guest)
      context.fail!(message: 'Wrong color!')
    end
  end
end
