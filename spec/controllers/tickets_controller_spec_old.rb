# frozen_string_literal: true

require 'spec_helper'

RSpec.describe TicketsController do
  fixtures :tickets

  it 'should get index' do
    get tickets_url, as: :json
    assert_response :success
  end

  it 'should create ticket' do
    assert_difference('Ticket.count') do
      post tickets_url,
           params: { ticket: { assigned_user_id_id: @ticket.assigned_user_id_id, description: @ticket.description, due_date: @ticket.due_date, progress: @ticket.progress, status_id: @ticket.status_id, title: @ticket.title } }, as: :json
    end

    assert_response 201
  end

  it 'should show ticket' do
    get ticket_url(@ticket), as: :json
    assert_response :success
  end

  it 'should update ticket' do
    patch ticket_url(@ticket),
          params: { ticket: { assigned_user_id_id: @ticket.assigned_user_id_id, description: @ticket.description, due_date: @ticket.due_date, progress: @ticket.progress, status_id: @ticket.status_id, title: @ticket.title } }, as: :json
    assert_response 200
  end

  it 'should destroy ticket' do
    assert_difference('Ticket.count', -1) do
      delete ticket_url(@ticket), as: :json
    end

    assert_response 204
  end
end
