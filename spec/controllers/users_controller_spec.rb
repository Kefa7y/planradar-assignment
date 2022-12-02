# frozen_string_literal: true
# # frozen_string_literal: true

# require 'spec_helper'

# RSpec.describe UsersController do
#   setup do
#     @user = users(:one)
#   end

#   test 'should get index' do
#     get users_url, as: :json
#     assert_response :success
#   end

#   test 'should create user' do
#     assert_difference('User.count') do
#       post users_url,
#            params: { user: { due_date_reminder_interval: @user.due_date_reminder_interval, due_date_reminder_time: @user.due_date_reminder_time, mail: @user.mail, name: @user.name, send_due_date_reminder: @user.send_due_date_reminder, time_zone: @user.time_zone } }, as: :json
#     end

#     assert_response 201
#   end

#   test 'should show user' do
#     get user_url(@user), as: :json
#     assert_response :success
#   end

#   test 'should update user' do
#     patch user_url(@user),
#           params: { user: { due_date_reminder_interval: @user.due_date_reminder_interval, due_date_reminder_time: @user.due_date_reminder_time, mail: @user.mail, name: @user.name, send_due_date_reminder: @user.send_due_date_reminder, time_zone: @user.time_zone } }, as: :json
#     assert_response 200
#   end

#   test 'should destroy user' do
#     assert_difference('User.count', -1) do
#       delete user_url(@user), as: :json
#     end

#     assert_response 204
#   end
# end
