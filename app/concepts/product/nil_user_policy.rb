class Product::NilUserPolicy < Hello::Policy

  def show?
    !model.pro?
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
