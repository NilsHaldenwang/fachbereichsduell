require 'test_helper'

class QuestionsControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get reload_check" do
    get :reload_check
    assert_response :success
  end

  test "should get submit_answer" do
    get :submit_answer
    assert_response :success
  end

end
