class ModelPolicy
  attr_reader :user_policy
  delegate :user, :record, :index?, :show?, :create?, :new?, :update?, :edit?, :destroy?, :scope, to: :user_policy

  def initialize(user, record)
    user_class = user ? user.class.name : 'NilUser'
    user_policy_class = Object.const_get(user_class + self.class.name)
    @user_policy = user_policy_class.new(user, record)
  end

  class Scope
    attr_reader :user_scope
    delegate :user, :scope, :resolve, to: :user_scope

    def initialize(user, scope)
      user_class = user ? user.class.name : 'NilUser'
      @user_scope_class = Object.const_get(user_class + self.class.name)
      @user_scope = @user_scope_class.new(user, scope)
    end
  end
end
