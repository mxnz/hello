class NilUserProductPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(pro: false)
    end
  end

  def show?
    !record.pro?
  end

  def show_pro_attr?
    false
  end

  def update_pro_attr?
    false
  end

  def show_store_attr?
    false
  end
end
