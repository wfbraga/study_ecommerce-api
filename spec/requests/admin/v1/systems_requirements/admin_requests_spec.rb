require 'rails_helper'

RSpec.describe 'Admin::V1::SystemsRequirements as :admin', type: :request do
  let(:user) { create(:user) }

  context 'GET /systems_requirements' do
    let(:url) { '/admin/v1/systems_requirements' }
    let!(:systems_requirements) { create_list(:system_requirement, 5) }

    it 'returns all systems_requirements' do
      get url, headers: auth_header(user)
      expect(body_json['systems_requirements']).to contain_exactly *systems_requirements.as_json(only: %i(id name operational_system storage processor memory))
    end

    it 'retunrs success status' do
      get url, headers: auth_header(user)
      expect(response).to have_http_status(:ok)
    end
  end

  context 'POST /systems_requirements' do
    let(:url) { '/admin/v1/systems_requirements' }

    context 'with valid params' do
      let(:system_requirement_params) { { system_requirement: attributes_for(:system_requirement) }.as_json }

      it 'adds a new system_requirement' do
        expect do
          post url, headers: auth_header(user), params: system_requirement_params
        end.to change(SystemRequirement, :count).by(1)
      end

      it 'returns last added system_requirement' do
        post url, headers: auth_header(user), params: system_requirement_params
        expect_system_requirement = SystemRequirement.last.as_json(only: %i(id name operational_system storage video_board processor memory))
        expect(body_json['system_requirement']).to eq expect_system_requirement
      end

      it 'retunrs success status' do
        post url, headers: auth_header(user), params: system_requirement_params
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid params' do
      let(:system_requirement_invalid_params) do
        { system_requirement: attributes_for(:system_requirement, name: nil) }.to_json
      end

      it 'does not add a new system_requirement' do
        expect do
        post url, headers: auth_header(user), params: system_requirement_invalid_params
        end.to_not change(SystemRequirement, :count)
      end

      it 'return error messages' do
        post url, headers: auth_header(user), params: system_requirement_invalid_params
        expect(body_json['errors']['fields']).to have_key('name')
      end

      it 'returns unprocessable entity' do
        post url, headers: auth_header(user), params: system_requirement_invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  context 'PATCH /systems_requirements/:id' do
    let(:system_requirement) { create(:system_requirement) }
    let(:url) { "/admin/v1/systems_requirements/#{system_requirement.id}" }

    context 'with valid params' do
      let(:new_name) { 'New Name to system_requirement'}
      let(:system_requirement_params) { { system_requirement: { name: new_name } }.as_json }

      it 'updates system_requirement' do
        patch url, headers: auth_header(user), params: system_requirement_params
        system_requirement.reload
        expect(system_requirement.name).to eq new_name
      end

      it 'retunrs updated system_requirement' do
        patch url, headers: auth_header(user), params: system_requirement_params
        system_requirement.reload
        expect_system_requirement = system_requirement.as_json(only: %i(id name operational_system storage video_board processor memory))
        expect(body_json['system_requirement']).to eq expect_system_requirement
      end

      it 'returns success status' do
        patch url, headers: auth_header(user), params: system_requirement_params
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid params' do
      let(:system_requirement_invalid_params) do
        { system_requirement: attributes_for(:system_requirement, name: nil).as_json }
      end

      it 'does not update the system_requirement' do
        old_name = system_requirement.name
        patch url, headers: auth_header(user), params: system_requirement_invalid_params
        system_requirement.reload
        expect(system_requirement.name).to eq old_name
      end

      it 'return error messages' do
        patch url, headers: auth_header(user), params: system_requirement_invalid_params
        expect(body_json['errors']['fields']).to have_key('name')
      end

      it 'returns unprocessable entity' do
        patch url, headers: auth_header(user), params: system_requirement_invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  context 'DELETE /system_requirement/:id' do
    let!(:system_requirement) { create(:system_requirement) }
    let(:url) { "/admin/v1/systems_requirements/#{system_requirement.id}" }

    context 'with no associated Game' do
      it 'removes system_requirement' do
        expect do
          delete url, headers: auth_header(user)
        end.to change(SystemRequirement, :count).by(-1)
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

    context 'with an associated Game' do
      before(:each) do
        create(:game, system_requirement: system_requirement)
      end

      it 'does not removes SystemRequirement' do
        expect do
          delete url, headers: auth_header(user)
        end.to_not change(SystemRequirement, :count)
      end

      it 'returns unprocessable_entity status' do
        delete url, headers: auth_header(user)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns error on :base key' do
        delete url, headers: auth_header(user)
        expect(body_json['errors']['fields']).to have_key('base')
      end
    end
  end
end
