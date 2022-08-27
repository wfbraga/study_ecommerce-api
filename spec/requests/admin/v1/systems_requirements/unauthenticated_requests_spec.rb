require 'rails_helper'

RSpec.describe 'Admin::V1::systems_requirements unauthenticated', type: :request do
  let(:user) { create(:user, profile: :client) }

  context 'GET /systems_requirements' do
    let(:url) { '/admin/v1/systems_requirements' }
    let!(:systems_requirements) { create_list(:coupon, 5) }

    before(:each) { get url }

    include_examples 'unauthenticated access'
  end

  context 'POST /systems_requirements' do
    let(:url) { '/admin/v1/systems_requirements' }

    before(:each) { post url }
    include_examples 'unauthenticated access'
  end

  context 'PATCH /systems_requirements/:id' do
    let(:coupon) { create(:coupon) }
    let(:url) { "/admin/v1/systems_requirements/#{coupon.id}" }

    before(:each) { patch url }
    include_examples 'unauthenticated access'
  end

  context 'DELETE /coupon/:id' do
    let!(:coupon) { create(:coupon) }
    let(:url) { "/admin/v1/systems_requirements/#{coupon.id}" }

    before(:each) { delete url }
    include_examples 'unauthenticated access'
  end
end