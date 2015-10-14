class Product < ActiveRecord::Base

  class Show < Trailblazer::Operation
    include Model, Trailblazer::Operation::Policy
    model Product, :find
    policy Product::Policy, :show?
  end

  class Create < Trailblazer::Operation
    include Model, Responder, Trailblazer::Operation::Policy
    model Product, :create
    policy Product::Policy, :create?

    contract do
      include Reform::Form::ModelReflections

      property :name
      property :description
      property :photo
      property :remove_photo
      property :store

      validates :name, presence: true
      validates_uniqueness_of :name
      validates :store, presence: true
    end

    def process(params)
      contract.store = params[:current_user].store
      validate(params[:product]) do |f|
        f.save
      end
    end
  end

  class Update < Create
    action :update
    policy Product::Policy, :update?
  end

  class UpdateProAttr < Trailblazer::Operation
    include Model, Trailblazer::Operation::Policy
    model Product, :update
    policy Product::Policy, :update_pro_attr?

    contract do
      include Reform::Form::ModelReflections

      property :pro
    end

    def process(params)
      contract.pro = !contract.pro
      contract.save
    end
  end

  class Destroy < Trailblazer::Operation
    include Model
    model Product, :find

    def process(params)
      model.destroy!
    end
  end
end
