require 'rails_helper'

RSpec.describe ProductPolicy do
  subject { described_class }
  let!(:product) { create(:product, pro: false) }
  let!(:pro_product) { create(:product, pro: true) }


  context 'for unknown user' do
    permissions ".scope" do
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


  context 'for guest' do
    let(:guest) { create(:guest) }

    permissions ".scope" do
      it 'returns all products' do
        expect(Pundit.policy_scope(guest, Product).all.count).to eq Product.all.count
      end
    end

    permissions :show? do
      it { is_expected.to permit(guest, product) }
      it { is_expected.to permit(guest, pro_product) }
    end

    permissions :create? do
      it { is_expected.to_not permit(guest, build(:product)) }
    end

    permissions :update? do
      it { is_expected.to_not permit(guest, product) }
    end

    permissions :destroy? do
      it { is_expected.to_not permit(guest, product) }
    end

    permissions :show_pro_attr? do
      it { is_expected.to permit(guest, product) }
      it { is_expected.to permit(guest, pro_product) }
    end

    permissions :update_pro_attr? do
      it { is_expected.to_not permit(guest, product) }
      it { is_expected.to_not permit(guest, pro_product) }
    end
  end


  context 'for store owner' do
    let(:owner) { create(:owner) }

    permissions ".scope" do
      it 'returns all products' do
        expect(Pundit.policy_scope(owner, Product).all.count).to eq Product.all.count
      end
    end

    permissions :show? do
      it { is_expected.to permit(owner, product) }
      it { is_expected.to permit(owner, pro_product) }
    end

    permissions :create? do
      it { is_expected.to permit(owner, build(:product)) }
    end

    permissions :update? do
      it { is_expected.to permit(owner, product) }
      it { is_expected.to permit(owner, pro_product) }
    end

    permissions :destroy? do
      it { is_expected.to permit(owner, product) }
      it { is_expected.to permit(owner, pro_product) }
    end

    permissions :show_pro_attr? do
      it { is_expected.to permit(owner, product) }
      it { is_expected.to permit(owner, pro_product) }
    end

    permissions :update_pro_attr? do
      it { is_expected.to_not permit(owner, product) }
      it { is_expected.to_not permit(owner, pro_product) }
    end
  end


  context 'for admin' do
    let(:admin) { create(:admin) }

    permissions ".scope" do
      it 'returns all products' do
        expect(Pundit.policy_scope(admin, Product).all.count).to eq Product.all.count
      end
    end

    permissions :show? do
      it { is_expected.to permit(admin, product) }
      it { is_expected.to permit(admin, pro_product) }
    end

    permissions :create? do
      it { is_expected.to_not permit(admin, build(:product)) }
    end

    permissions :update? do
      it { is_expected.to_not permit(admin, product) }
    end

    permissions :destroy? do
      it { is_expected.to_not permit(admin, product) }
    end

    permissions :show_pro_attr? do
      it { is_expected.to permit(admin, product) }
      it { is_expected.to permit(admin, pro_product) }
    end

    permissions :update_pro_attr? do
      it { is_expected.to permit(admin, product) }
      it { is_expected.to permit(admin, pro_product) }
    end
  end
end
