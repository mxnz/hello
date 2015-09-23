class GuestProductPolicy < ApplicationPolicy
  class Scope < Scope
  end

  def show
    true
  end

  def show_pro_attr?
    true
  end

  def update_pro_attr?
    false
  end
end
