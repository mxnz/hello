class ProductPolicy < ModelPolicy
  delegate :show_pro_attr?, :update_pro_attr?, to: :user_policy
  class Scope < Scope
  end
end
