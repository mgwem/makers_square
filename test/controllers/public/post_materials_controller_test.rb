require "test_helper"

class Public::PostMaterialsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_post_materials_new_url
    assert_response :success
  end

  test "should get edit" do
    get public_post_materials_edit_url
    assert_response :success
  end
end
