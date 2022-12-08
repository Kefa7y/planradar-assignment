# frozen_string_literal: true

require 'spec_helper'

RSpec.describe TicketsController do
  fixtures :tickets, :users

  def parse_ticket_to_json(ticket)
    ticket_json = ticket.serializable_hash.except('jid')
    %w[due_date created_at updated_at].each do |key|
      ticket_json[key] = ticket_json[key]&.as_json
    end

    ticket_json
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
      expect(response.body).to include_json parse_ticket_to_json(tickets(:first))
    end
  end

  describe 'POST #create' do
    render_views

    before do
      post :create, params: { ticket: ticket_params }, format: :json
    end

    context 'when passing valid Ticket params' do
      let(:ticket_params) do
        {
          title: 'Test Ticket',
          description: 'Test Ticket Description',
          assigned_user_id: users(:first).id
        }
      end
      let(:ticket) { Ticket.find_by(title: ticket_params[:title]) }

      it 'returns HTTP status CREATED' do
        expect(response).to have_http_status(:created)
      end

      it 'renders show template' do
        expect(response).to render_template('show')
      end

      it 'renders _user template' do
        expect(response).to render_template('_ticket')
      end

      it 'stores the Ticket correctly' do
        expect(ticket.serializable_hash).to include_json ticket_params
      end

      it 'renders the correct ticket' do
        expect(response.body).to include_json parse_ticket_to_json(ticket)
      end
    end

    context 'when passing invalid Ticket params' do
      let(:ticket_params) do
        {
          description: 'Test Ticket Description',
          assigned_user_id: users(:first).id
        }
      end

      it 'returns HTTP status UNPROCESSABLE_ENTITY' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'renders the error correctly' do
        expect(response.body).to eq({ title: ["can't be blank"] }.to_json)
      end
    end
  end

  describe 'PUT #update' do
    render_views

    before do
      put :update, params: { id: tickets(:first).id, ticket: ticket_params }, format: :json
    end

    context 'when passing valid Ticket params' do
      let(:ticket_params) do
        {
          title: 'Test Ticket',
          description: 'Test Ticket Description',
          assigned_user_id: users(:first).id
        }
      end
      let(:ticket) { Ticket.find_by(title: ticket_params[:title]) }

      it 'returns HTTP status OK' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders show template' do
        expect(response).to render_template('show')
      end

      it 'renders _user template' do
        expect(response).to render_template('_ticket')
      end

      it 'stores the Ticket correctly' do
        expect(ticket.serializable_hash).to include_json ticket_params
      end

      it 'renders the correct ticket' do
        expect(response.body).to include_json parse_ticket_to_json(ticket)
      end
    end

    context 'when passing invalid Ticket params' do
      let(:ticket_params) do
        {
          description: 'Test Ticket Description',
          assigned_user_id: 'invalid'
        }
      end

      it 'returns HTTP status UNPROCESSABLE_ENTITY' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'renders the error correctly' do
        expect(response.body).to eq({ user: ['must exist'] }.to_json)
      end
    end
  end

  describe 'DELETE #destroy' do
    render_views

    before do
      delete :destroy, params: { id: tickets(:first).id }, format: :json
    end

    it 'returns HTTP status OK' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns empty body' do
      expect(response.body).to eq ''
    end

    it 'deletes the Ticket record from the database' do
      expect { tickets(:first).reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
