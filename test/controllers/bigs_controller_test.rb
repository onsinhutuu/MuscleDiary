require 'test_helper'

class BigsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get bigs_new_url
    assert_response :success
  end

end
