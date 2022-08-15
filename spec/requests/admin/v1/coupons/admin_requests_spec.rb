require 'rails_helper'

RSpec.describe 'Admin::V1::Coupons as admin', type: :request do
  let(:user) { create(:user) }

  context 'GET /coupons' do
    let(:url) { '/admin/v1/coupons'}
    let!(:coupons) { create_list(:coupon, 5) }

    it 'returns all coupons' do
      get url, headers: auth_header(user)
      expect(body_json['coupons']).to contain_exactly *coupons.as_json(only: %i(code status discount_value due_date))
    end

    it 'returns success status' do
      get url, headers: auth_header(user)
      expect(response).to have_http_status(:ok)
    end
  end

  context 'POST /coupons' do
    let(:url) { '/admin/v1/coupons' }

    context 'with valid params' do
      let(:coupon_params) { { coupon: attributes_for(:coupon) }.as_json }

      it 'adds a new coupon' do
        expect do
          post url, headers: auth_header(user), params: coupon_params
        end.to change(Coupon, :count).by(1)
      end

      it 'return last added coupon' do
        post url, headers: auth_header(user), params: coupon_params
        expect_coupon = Coupon.last.as_json(only: %i(id code status discount_value due_date))
        expect(body_json['coupon']).to eq expect_coupon
      end

      it 'returns succes status' do
        post url, headers: auth_header(user), params: coupon_params
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid params' do
      let(:coupon_invalid_params) do
        { coupon: attributes_for(:coupon, code: nil).as_json }
      end

      it 'does not add a new coupon' do
        expect do
          post url, headers: auth_header(user), params: coupon_invalid_params
        end.to_not change(Coupon, :count)
      end

      it 'return error messages' do
        post url, headers: auth_header(user), params: coupon_invalid_params
        expect(body_json['errors']['fields']).to have_key("code")
      end

      it 'returns unprocessabe entity status' do
        post url, headers: auth_header(user), params: coupon_invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  context 'PATCH /coupons/:id' do
    let(:coupon) { create(:coupon) }
    let(:url) { "/admin/v1/coupons/#{coupon.id}" }

    context 'with valid params' do
      let(:new_discount) { 10 }
      let(:coupon_params) { { coupon: { discount_value: new_discount } }.as_json }

      it 'updates category' do
        patch url, headers: auth_header(user), params: coupon_params
        coupon.reload
        expect(coupon.discount_value).to eq new_discount
      end

      it 'retunrs updated category' do
        patch url, headers: auth_header(user), params: coupon_params
        coupon.reload
        expect_coupon = coupon.as_json(only: %i(id code status discount_value due_date))
        expect(body_json['coupon']).to eq expect_coupon
      end

      it 'returns success status' do
        patch url, headers: auth_header(user), params: coupon_params
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid params' do
      let(:coupon_invalid_params) do
        { coupon: attributes_for(:coupon, code: nil).as_json }
      end

      it 'does not update coupon' do
        old_code = coupon.code
        patch url, headers: auth_header(user), params: coupon_invalid_params
        coupon.reload
        expect(coupon.code).to eq old_code
      end

      it 'return error messages' do
        patch url, headers: auth_header(user), params: coupon_invalid_params
        expect(body_json['errors']['fields']).to have_key("code")
      end

      it 'returns unprocessabe entity status' do
        patch url, headers: auth_header(user), params: coupon_invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  context 'DELETE /coupon/:id' do
    let!(:coupon) { create(:coupon) }
    let(:url) { "/admin/v1/coupons/#{coupon.id}" }

    it 'removes coupon' do
      expect do
        delete url, headers: auth_header(user)
      end.to change(Coupon, :count).by(-1)
    end

    it 'returns success status' do
      delete url, headers: auth_header(user)
      expect(response).to have_http_status(:no_content)
    end

    it 'does not returns any body content' do
      delete url, headers: auth_header(user)
      expect(body_json).to_not be_present
    end
  end

end