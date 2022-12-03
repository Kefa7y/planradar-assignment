# frozen_string_literal: true

require 'spec_helper'

RSpec.describe TicketsController do
  fixtures :tickets

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
      expect(response).to render_template('_ticket')
    end

    it 'returns the correct amount of tickets' do
      expect(JSON.parse(response.body)).to have_exactly(tickets.size).items
    end
  end

  describe 'GET #show' do
    render_views

    before do
      get :show, params: { id: tickets(:first).id }, format: :json
    end

    it 'returns HTTP status OK' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders show template' do
      expect(response).to render_template('show')
    end

    it 'renders _user template' do
      expect(response).to render_template('_ticket')
    end

    it 'renders the correct ticket' do
      expected = tickets(:first).serializable_hash
      %w[due_date created_at updated_at].each do |key|
        expected[key] = expected[key].as_json
      end

      expect(response.body).to include_json expected
    end
  end

  # test 'should create user' do
  #   assert_difference('User.count') do
  #     post users_url,
  #          params: { user: { due_date_reminder_interval: @user.due_date_reminder_interval, due_date_reminder_time: @user.due_date_reminder_time, mail: @user.mail, name: @user.name, send_due_date_reminder: @user.send_due_date_reminder, time_zone: @user.time_zone } }, as: :json
  #   end

  #   assert_response 201
  # end

  # test 'should update user' do
  #   patch user_url(@user),
  #         params: { user: { due_date_reminder_interval: @user.due_date_reminder_interval, due_date_reminder_time: @user.due_date_reminder_time, mail: @user.mail, name: @user.name, send_due_date_reminder: @user.send_due_date_reminder, time_zone: @user.time_zone } }, as: :json
  #   assert_response 200
  # end
end
