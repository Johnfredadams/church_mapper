require 'test_helper'

class RenewRegionsControllerTest < ActionController::TestCase
  setup do
    @renew_region = renew_regions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:renew_regions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create renew_region" do
    assert_difference('RenewRegion.count') do
      post :create, renew_region: { name: @renew_region.name }
    end

    assert_redirected_to renew_region_path(assigns(:renew_region))
  end

  test "should show renew_region" do
    get :show, id: @renew_region
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @renew_region
    assert_response :success
  end

  test "should update renew_region" do
    patch :update, id: @renew_region, renew_region: { name: @renew_region.name }
    assert_redirected_to renew_region_path(assigns(:renew_region))
  end

  test "should destroy renew_region" do
    assert_difference('RenewRegion.count', -1) do
      delete :destroy, id: @renew_region
    end

    assert_redirected_to renew_regions_path
  end
end
