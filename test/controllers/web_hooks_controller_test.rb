require 'test_helper'

class WebHooksControllerTest < ActionController::TestCase
  test "should get eventbrite" do
    get :eventbrite
    assert_response :success
  end

end
