require 'rails_helper'

RSpec.describe OrderPolicy, type: :policy do
  subject { described_class }
  let(:product) { create(:product) }
  let(:pro_product) { create(:product, pro: true) }
  let(:order) { create(:order) }

  context 'for unknown user' do
    permissions :show? do
      it { is_expected.to_not permit(nil, order) }
    end

    permissions :create? do
      it { is_expected.to_not permit(nil, Order) }
    end
  end

  context 'for guest' do
    let(:guest) { create(:guest) }
    let(:own_order) { create(:order, user: guest) }

    permissions :show? do
      context 'for own order' do
        it { is_expected.to permit(guest, own_order) } 
      end

      context "for another's order" do
        it { is_expected.to_not permit(guest, order) }
      end
    end

    permissions :create? do
      context 'when product is pro' do
        it { is_expected.to_not permit(guest, Order.new(product: pro_product))  }
      end

      context 'when product without store' do
        before { product.store = nil }
        it { is_expected.to_not permit(guest, Order.new(product: product))}
      end

      context "when guest's email ends with .com" do
        before { guest.email = 'aaa@bb.com' }
        it { is_expected.to_not permit(guest, Order.new(product: product)) }
      end

      context "when all conditions are valid" do
        before { guest.email = 'aaa@bb.org' }
        it { is_expected.to permit(guest, Order.new(product: product)) }
      end
    end
  end

  context 'for store owner' do
    let(:owner) { create(:owner) }

    permissions :show? do
      it { is_expected.to_not permit(owner, order) }
    end

    permissions :create? do
      it { is_expected.to_not permit(owner, Order) }
    end
  end

  context 'for admin' do
    let(:admin) { create(:admin) }

    permissions :show? do
      it { is_expected.to_not permit(admin, order) }
    end

    permissions :create? do
      it { is_expected.to_not permit(admin, Order) }
    end
  end
end
