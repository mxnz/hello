class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @products = policy_scope(Product.all)
    respond_with(@products)
  end

  def new
    form Product::Create
  end

  def create
    respond Product::Create
  end

  def show
    present Product::Show
  end

  def edit
    form Product::Update
  end

  def update
    respond Product::Update
  end

  def destroy
    run Product::Destroy
    redirect_to products_path
  end

  def update_pro_attr
    run Product::UpdateProAttr
    render :show
  end
end
