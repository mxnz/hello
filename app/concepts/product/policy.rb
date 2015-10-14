class Product::Policy
  delegate :user,
           :model,
           :index?,
           :show?,
           :create?,
           :new?,
           :update?,
           :edit?,
           :destroy?,
           :show_pro_attr?,
           :update_pro_attr?,
           :show_store_attr?,
           to: :user_policy

  def initialize(user, model)
    user_policy_class =
      case user
      when NilClass
        Product::NilUserPolicy
      when Guest
        Product::GuestPolicy
      when Owner
        Product::OwnerPolicy
      when Admin
        Product::AdminPolicy
      else
        fail 'Unknown user type'
      end
    @user_policy = user_policy_class.new(user, model)
  end

  private
    attr_reader :user_policy
end
