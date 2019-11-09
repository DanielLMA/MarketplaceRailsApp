require 'test_helper'

class RunnersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get runners_index_url
    assert_response :success
  end

  test "should get edit" do
    get runners_edit_url
    assert_response :success
  end

  test "should get payment" do
    get runners_payment_url
    assert_response :success
  end

end
