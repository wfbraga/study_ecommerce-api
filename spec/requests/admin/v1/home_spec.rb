require 'rails_helper'

describe 'Home', type: :request do
  let(:user) { create(:user) }

  it 'Test Home' do
    get '/admin/v1/home', headers: auth_header(user)
    expect(body_json).to eq({ 'message' => 'Yahoo!' })
  end
end
