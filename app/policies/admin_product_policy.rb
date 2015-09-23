class AdminProductPolicy < ApplicationPolicy
  def show?
    true
  end

  def show_pro_attr?
    true
  end

  def update_pro_attr?
    true
  end

  def show_store_attr?
    true
  end
end
