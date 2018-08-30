require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @user = users(:one)
  end

  test 'visit cant check user profiles' do
    # sign_in @user
    get user_url(@user)
    assert_redirected_to new_user_registration_path
  end
end
