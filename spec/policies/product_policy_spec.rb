require 'rails_helper'

RSpec.describe ProductPolicy do
  subject { described_class }
  let(:product) { create(:product, pro: false) }
  let(:pro_product) { create(:product, pro: true) }

  context 'for unknown user' do
    permissions ".scope" do
      before do
        product 
        pro_product
      end

      it 'returns products' do
        expect(Pundit.policy_scope(nil, Product).all).to include(product)
      end

      it "doesn't return pro products" do
        expect(Pundit.policy_scope(nil, Product).all).to_not include(pro_product)
      end
    end

    permissions :show? do
      it { is_expected.to      permit(nil, product) }
      it { is_expected.to_not  permit(nil, pro_product) }
    end

    permissions :create? do
      it { is_expected.to_not permit(nil, build(:product)) }
    end

    permissions :update? do
      it { is_expected.to_not permit(nil, product) }
    end

    permissions :destroy? do
      it { is_expected.to_not permit(nil, product) }
    end

    permissions :show_pro_attr? do
      it { is_expected.to_not permit(nil, product) }
      it { is_expected.to_not permit(nil, pro_product) }
    end

    permissions :update_pro_attr? do
      it { is_expected.to_not permit(nil, product) }
      it { is_expected.to_not permit(nil, product) }
    end
  end

  context 'for guest', skip: true do

    let(:guest) { create(:guest) }


    permissions ".scope" do
      pending "add some examples to (or delete) #{__FILE__}"
    end

    permissions :show? do
      pending "add some examples to (or delete) #{__FILE__}"
    end

    permissions :create? do
      pending "add some examples to (or delete) #{__FILE__}"
    end

    permissions :update? do
      pending "add some examples to (or delete) #{__FILE__}"
    end

    permissions :destroy? do
      pending "add some examples to (or delete) #{__FILE__}"
    end
  end
end
