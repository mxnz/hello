class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_product, only: [:new, :create]

  def new
    @order = Order.new(product: @product, user: current_user)
    authorize @order
  end

  def create
    authorize(Order.new(product: @product))
    context = CreateOrder.(product: @product, guest: current_user)
    respond_with(@order = context.order)
  end

  def show
    @order = Order.find(params[:id])
    respond_with(@order)
  end

  private
   
    def load_product
      @product = Product.find(params[:product_id])
    end
end
