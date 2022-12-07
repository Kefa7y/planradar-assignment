# frozen_string_literal: true

require 'spec_helper'

RSpec.describe UsersController do
  fixtures :users

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
      expected = users(:first).serializable_hash
      expected['due_date_reminder_time'] = TimeUtils.parse_time_of_day(
        expected['due_date_reminder_time'].in_time_zone(expected['time_zone'])
      )
      expect(response.body).to include_json expected
    end
  end
end
