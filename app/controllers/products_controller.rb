class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_product, ->() { authorize @product }, only: [:show, :edit, :update, :destroy]

  def index
    @products = policy_scope(Product.all)
    respond_with(@products)
  end

  def new
    @product = Product.new
    authorize @product
    respond_with(@product = Product.new)
  end

  def create
    authorize Product
    @product = Product.create(product_params.merge(store: current_user.store))
    respond_with(@product)
  end

  def show
    respond_with(@product)
  end

  def edit
    respond_with(@product)
  end

  def update
    @product.update(product_params)
    respond_with(@product)
  end

  def destroy
    respond_with(@product.destroy!)
  end


  private

    def load_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :description, :photo, :remove_photo)
    end
end
