require 'test_helper'

class Admin::ProfilesControllerTest < ActionController::TestCase
  setup do
    @admin_profile = admin_profiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_profiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_profile" do
    assert_difference('Admin::Profile.count') do
      post :create, :admin_profile => @admin_profile.attributes
    end

    assert_redirected_to admin_profile_path(assigns(:admin_profile))
  end

  test "should show admin_profile" do
    get :show, :id => @admin_profile.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @admin_profile.to_param
    assert_response :success
  end

  test "should update admin_profile" do
    put :update, :id => @admin_profile.to_param, :admin_profile => @admin_profile.attributes
    assert_redirected_to admin_profile_path(assigns(:admin_profile))
  end

  test "should destroy admin_profile" do
    assert_difference('Admin::Profile.count', -1) do
      delete :destroy, :id => @admin_profile.to_param
    end

    assert_redirected_to admin_profiles_path
  end
end
