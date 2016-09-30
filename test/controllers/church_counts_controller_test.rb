require 'test_helper'

class ChurchCountsControllerTest < ActionController::TestCase
  setup do
    @church_count = church_counts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:church_counts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create church_count" do
    assert_difference('ChurchCount.count') do
      post :create, church_count: { church_id: @church_count.church_id, count_approx: @church_count.count_approx, count_day: @church_count.count_day, count_month: @church_count.count_month, count_number: @church_count.count_number, count_type: @church_count.count_type, count_year: @church_count.count_year }
    end

    assert_redirected_to church_count_path(assigns(:church_count))
  end

  test "should show church_count" do
    get :show, id: @church_count
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @church_count
    assert_response :success
  end

  test "should update church_count" do
    patch :update, id: @church_count, church_count: { church_id: @church_count.church_id, count_approx: @church_count.count_approx, count_day: @church_count.count_day, count_month: @church_count.count_month, count_number: @church_count.count_number, count_type: @church_count.count_type, count_year: @church_count.count_year }
    assert_redirected_to church_count_path(assigns(:church_count))
  end

  test "should destroy church_count" do
    assert_difference('ChurchCount.count', -1) do
      delete :destroy, id: @church_count
    end

    assert_redirected_to church_counts_path
  end
end
