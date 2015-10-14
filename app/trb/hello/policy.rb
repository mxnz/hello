class Hello::Policy

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  private 
    attr_reader :user, :model

    def initialize(user, model)
      @user = user
      @model = model
    end
end
