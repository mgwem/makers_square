require "test_helper"

class Public::MembersControllerTest < ActionDispatch::IntegrationTest
  test "should get my_page" do
    get public_members_my_page_url
    assert_response :success
  end

  test "should get edit" do
    get public_members_edit_url
    assert_response :success
  end

  test "should get update" do
    get public_members_update_url
    assert_response :success
  end

  test "should get unsubscribe" do
    get public_members_unsubscribe_url
    assert_response :success
  end

  test "should get destroy" do
    get public_members_destroy_url
    assert_response :success
  end

  test "should get show" do
    get public_members_show_url
    assert_response :success
  end
end
