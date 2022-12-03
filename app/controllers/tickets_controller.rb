# frozen_string_literal: true

class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[show update destroy]

  def index
    @tickets = Ticket.all
  end

  def show; end

  def create
    @ticket = Ticket.new(ticket_params)

    if @ticket.save
      render :show, status: :created, location: @ticket
    else
      render json: @ticket.errors, status: :unprocessable_entity
    end
  end

  def update
    if @ticket.update(ticket_params)
      render :show, status: :ok, location: @ticket
    else
      render json: @ticket.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @ticket.destroy
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:title, :description, :assigned_user_id, :due_date, :status_id, :progress)
  end
end
