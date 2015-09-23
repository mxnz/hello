class GuestProductPolicy < ApplicationPolicy
  def show
    true
  end

  def show_pro_attr?
    true
  end

  def update_pro_attr?
    false
  end

  def show_store_attr?
    false
  end
end
