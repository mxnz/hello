class OrderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show
    false
  end

  def create?
    return false if user.class != Guest
    order = record
    product = order.product
    return false if product.pro?
    return false if product.store.blank?
    return false if user.email.end_with? '.com'
    true
  end
end
