require 'test_helper'

class PlacesControllerTest < ActionController::TestCase

  test "index" do
    FactoryGirl.create(:place)
    get :index
    assert_response :success
  end

  test "show found" do
    place = FactoryGirl.create(:place)
    get :show, :id => place.id
    assert_response :success
  end

  test "show not found" do
    assert_raises(ActiveRecord::RecordNotFound) do
      get :show, :id => 'abc'
    end
  end

  test "new not signed in" do
    get :new
    assert_redirected_to new_user_session_path
  end

  test "new" do
    user = FactoryGirl.create(:user)
    sign_in user

    get :new
    assert_response :success
  end

  test "create not signed in" do
    assert_no_difference 'Place.count' do
      post :create, {:place => {
        :name => 'abc',
        :address => 'abc street',
        :description => 'about abc',
        :latitude => 42.3631519,
        :longitude => -71.056098
        }
      }
    end
    assert_redirected_to new_user_session_path
  end

  test "create" do
    user = FactoryGirl.create(:user)
    sign_in user

    assert_difference 'Place.count' do
      post :create, {:place => {
        :name => 'abc',
        :address => 'abc street',
        :description => 'about abc',
        :latitude => 42.3631519,
        :longitude => -71.056098
        }
      }
    end
    assert_redirected_to root_path
    assert_equal 1, user.places.count
  end

  test "create invalid" do
    user = FactoryGirl.create(:user)
    sign_in user

    assert_no_difference 'Place.count' do
      post :create, {:place => {
        :name => '',
        :address => '',
        :description => '',
        :latitude => nil,
        :longitude => nil
        }
      }
    end
    assert_response :unprocessable_entity
  end

  test "edit not logged in" do
    place = FactoryGirl.create(:place)
    get :edit, :id => place.id
    assert_redirected_to new_user_session_path
  end

  test "edit found" do
    place = FactoryGirl.create(:place)
    sign_in place.user

    get :edit, :id => place.id
    assert_response :success
  end

  test "edit not found" do
  	assert_raises(ActiveRecord::RecordNotFound) do
      sign_in FactoryGirl.create(:user)
      get :edit, :id => 'something'
    end
  end

  test "update not logged in" do
    place = FactoryGirl.create(:place, :name => 'abc')
    put :update, :id => place.id, :place => {:name => 'def'}
    assert_redirected_to new_user_session_path
  end

  test "update as a different user" do
    sign_in FactoryGirl.create(:user)
    place = FactoryGirl.create(:place, :name => 'abc')
    put :update, :id => place.id, :place => {:name => 'def'}
    assert_response :forbidden
  end

  test "update success" do
    place = FactoryGirl.create(:place, :name => 'abc')
    sign_in place.user
    put :update, :id => place.id, :place => {:name => 'def'}
    assert_redirected_to place_path(place)
    assert_equal 'def', place.reload.name
  end

  test "update not found" do
    assert_raises(ActiveRecord::RecordNotFound) do
      sign_in FactoryGirl.create(:user)
      put :update, :id => 'abc', :place => {:name => 'ghi'}
    end
  end

  test "update validation error" do
    place = FactoryGirl.create(:place)
    sign_in place.user
    put :update, :id => place.id, :place => {:name => ''}
    assert place.reload.name.present?
    assert_response :unprocessable_entity
  end

  test "destroy not logged in" do
    place = FactoryGirl.create(:place)
    assert_no_difference 'Place.count' do
      delete :destroy, :id => place.id
    end
    assert_redirected_to new_user_session_path
  end

  test "destroy someone else's" do
    place = FactoryGirl.create(:place)
    sign_in FactoryGirl.create(:user)
    assert_no_difference 'Place.count' do
      delete :destroy, :id => place.id
    end
    assert_response :forbidden
  end

  test "destroy success" do
    place = FactoryGirl.create(:place)
    sign_in place.user
    delete :destroy, :id => place.id
    assert_redirected_to root_path
    assert_raises(ActiveRecord::RecordNotFound) do
      Place.find(place.id)
    end
  end

  test "destroy not found" do
    sign_in FactoryGirl.create(:user)
    assert_raises(ActiveRecord::RecordNotFound) do
      delete :destroy, :id => 'abc'
    end
  end

end