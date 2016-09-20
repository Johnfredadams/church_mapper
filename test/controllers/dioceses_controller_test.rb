require 'test_helper'

class DiocesesControllerTest < ActionController::TestCase
  setup do
    @diocese = dioceses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dioceses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create diocese" do
    assert_difference('Diocese.count') do
      post :create, diocese: { name: @diocese.name, province: @diocese.province }
    end

    assert_redirected_to diocese_path(assigns(:diocese))
  end

  test "should show diocese" do
    get :show, id: @diocese
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @diocese
    assert_response :success
  end

  test "should update diocese" do
    patch :update, id: @diocese, diocese: { name: @diocese.name, province: @diocese.province }
    assert_redirected_to diocese_path(assigns(:diocese))
  end

  test "should destroy diocese" do
    assert_difference('Diocese.count', -1) do
      delete :destroy, id: @diocese
    end

    assert_redirected_to dioceses_path
  end
end
