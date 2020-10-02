require 'test_helper'

class MusclesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get muscles_show_url
    assert_response :success
  end

  test "should get index" do
    get muscles_index_url
    assert_response :success
  end

  test "should get following" do
    get muscles_following_url
    assert_response :success
  end

  test "should get edit" do
    get muscles_edit_url
    assert_response :success
  end

  test "should get new" do
    get muscles_new_url
    assert_response :success
  end

end
