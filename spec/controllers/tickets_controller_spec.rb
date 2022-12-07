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
      expected = tickets(:first).serializable_hash.except('jid')
      %w[due_date created_at updated_at].each do |key|
        expected[key] = expected[key].as_json
      end

      expect(response.body).to include_json expected
    end
  end
end
