require 'test_helper'

class PartsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get parts_new_url
    assert_response :success
  end

end
