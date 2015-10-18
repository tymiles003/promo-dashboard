require 'test_helper'

class AccessCodesControllerTest < ActionController::TestCase
  setup do
    @access_code = access_codes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:access_codes)
  end

  test "should create access_code" do
    assert_difference('AccessCode.count') do
      post :create, access_code: { code: @access_code.code, user_id: @access_code.user_id }
    end

    assert_redirected_to access_code_path(assigns(:access_code))
  end

end
