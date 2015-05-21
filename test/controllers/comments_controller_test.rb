require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  
  test "create comment success" do
    user = FactoryGirl.create(:user)
    sign_in user
    place = FactoryGirl.create(:place)
    assert_difference 'place.comments.count' do
      post :create, :place_id => place.id, :comment => {
        :message => 'Some message',
      	:rating => '5_stars'
      }
    end
    assert_equal 1, place.comments.count
    assert_redirected_to place_path(place)
  end

  test "create comment not logged in" do
    post :create, :place_id => 'abc'
    assert_redirected_to new_user_session_path
  end

end
