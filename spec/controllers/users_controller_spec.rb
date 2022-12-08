# frozen_string_literal: true

require 'spec_helper'

RSpec.describe UsersController do
  fixtures :users

  def parse_user_to_json(user)
    user_json = user.serializable_hash
    if user_json['due_date_reminder_time'].present?
      user_json['due_date_reminder_time'] = TimeUtils.parse_time_of_day(
        user_json['due_date_reminder_time'].in_time_zone(user_json['time_zone'])
      )
    end

    user_json
  end

  describe 'GET #index' do
    render_views

    before do
      get :index, format: :json
    end

    it 'returns HTTP status OK' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders index template' do
      expect(response).to render_template('index')
    end

    it 'renders _user template' do
      expect(response).to render_template('_user')
    end

    it 'returns the correct amount of users' do
      expect(JSON.parse(response.body)).to have_exactly(users.size).items
    end
  end

  describe 'GET #show' do
    render_views

    before do
      get :show, params: { id: users(:first).id }, format: :json
    end

    it 'returns HTTP status OK' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders show template' do
      expect(response).to render_template('show')
    end

    it 'renders _user template' do
      expect(response).to render_template('_user')
    end

    it 'renders the correct user' do
      expect(response.body).to include_json(parse_user_to_json(users(:first)))
    end
  end

  describe 'POST #create' do
    render_views

    before do
      post :create, params: { user: user_params }, format: :json
    end

    context 'when passing valid User params' do
      let(:user_params) do
        {
          name: 'Test User',
          mail: 'test@planradar.com',
          send_due_date_reminder: false,
          time_zone: 'EET'
        }
      end
      let(:user) { User.find_by(name: user_params[:name]) }

      it 'returns HTTP status CREATED' do
        expect(response).to have_http_status(:created)
      end

      it 'renders show template' do
        expect(response).to render_template('show')
      end

      it 'renders _user template' do
        expect(response).to render_template('_user')
      end

      it 'stores the User correctly' do
        expect(user.serializable_hash).to include_json user_params
      end

      it 'renders the correct User' do
        expect(response.body).to include_json parse_user_to_json(user)
      end
    end

    context 'when passing invalid User params' do
      let(:user_params) do
        {
          mail: 'test@planradar.com',
          send_due_date_reminder: false,
          time_zone: 'EET'
        }
      end

      it 'returns HTTP status UNPROCESSABLE_ENTITY' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'renders the error correctly' do
        expect(response.body).to eq({ name: ["can't be blank"] }.to_json)
      end
    end
  end

  describe 'PUT #update' do
    render_views

    before do
      put :update, params: { id: users(:first).id, user: user_params }, format: :json
    end

    context 'when passing valid User params' do
      let(:user_params) do
        {
          name: 'Test User',
          mail: 'test@planradar.com',
          send_due_date_reminder: false,
          time_zone: 'EET'
        }
      end

      let(:user) { User.find_by(name: user_params[:name]) }

      it 'returns HTTP status OK' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders show template' do
        expect(response).to render_template('show')
      end

      it 'renders _user template' do
        expect(response).to render_template('_user')
      end

      it 'stores the User correctly' do
        expect(user.serializable_hash).to include_json user_params
      end

      it 'renders the correct User' do
        expect(response.body).to include_json parse_user_to_json(user)
      end
    end

    context 'when passing invalid User params' do
      let(:user_params) do
        {
          name: nil,
          mail: 'test@planradar.com',
          send_due_date_reminder: false,
          time_zone: 'EET'
        }
      end

      it 'returns HTTP status UNPROCESSABLE_ENTITY' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'renders the error correctly' do
        expect(response.body).to eq({ name: ["can't be blank"] }.to_json)
      end
    end
  end
end
