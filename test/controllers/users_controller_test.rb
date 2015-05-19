require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  test "show found" do
    user = FactoryGirl.create(:user)
    sign_in user
    get :show, :id => user.id
    assert_response :success
  end

  test "show not found" do
    user = FactoryGirl.create(:user)
    assert_raises(ActiveRecord::RecordNotFound) do
      get :show, :id => 'abc'
    end
  end

end
