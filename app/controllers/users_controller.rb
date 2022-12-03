# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show update]

  def index
    @users = User.all
  end

  def show; end

  def create
    @user = User.new(user_params)
    if @user.save
      render :show, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render :show, status: :ok, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :mail, :send_due_date_reminder, :due_date_reminder_interval,
                                 :due_date_reminder_time, :time_zone)
  end
end
