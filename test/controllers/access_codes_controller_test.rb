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

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create access_code" do
    assert_difference('AccessCode.count') do
      post :create, access_code: { code: @access_code.code, invitee_info: @access_code.invitee_info, invitee_name: @access_code.invitee_name, invitee_url: @access_code.invitee_url, user_id: @access_code.user_id }
    end

    assert_redirected_to access_code_path(assigns(:access_code))
  end

  test "should show access_code" do
    get :show, id: @access_code
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @access_code
    assert_response :success
  end

  test "should update access_code" do
    patch :update, id: @access_code, access_code: { code: @access_code.code, invitee_info: @access_code.invitee_info, invitee_name: @access_code.invitee_name, invitee_url: @access_code.invitee_url, user_id: @access_code.user_id }
    assert_redirected_to access_code_path(assigns(:access_code))
  end

  test "should destroy access_code" do
    assert_difference('AccessCode.count', -1) do
      delete :destroy, id: @access_code
    end

    assert_redirected_to access_codes_path
  end
end
