require 'test_helper'

class ChurchesControllerTest < ActionController::TestCase
  setup do
    @church = churches(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:churches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create church" do
    assert_difference('Church.count') do
      post :create, church: { average_weekly_attendance: @church.average_weekly_attendance, cofe_status: @church.cofe_status, description: @church.description, diocese: @church.diocese, funding: @church.funding, incumbent_age: @church.incumbent_age, incumbent_age_approx: @church.incumbent_age_approx, incumbent_name: @church.incumbent_name, incumbent_start_month: @church.incumbent_start_month, incumbent_start_year: @church.incumbent_start_year, locality: @church.locality, name: @church.name, network: @church.network, number_of_clergy_employed: @church.number_of_clergy_employed, number_of_staff: @church.number_of_staff, parish: @church.parish, postcode: @church.postcode, start_month: @church.start_month, start_year: @church.start_year, status: @church.status, vacant: @church.vacant }
    end

    assert_redirected_to church_path(assigns(:church))
  end

  test "should show church" do
    get :show, id: @church
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @church
    assert_response :success
  end

  test "should update church" do
    patch :update, id: @church, church: { average_weekly_attendance: @church.average_weekly_attendance, cofe_status: @church.cofe_status, description: @church.description, diocese: @church.diocese, funding: @church.funding, incumbent_age: @church.incumbent_age, incumbent_age_approx: @church.incumbent_age_approx, incumbent_name: @church.incumbent_name, incumbent_start_month: @church.incumbent_start_month, incumbent_start_year: @church.incumbent_start_year, locality: @church.locality, name: @church.name, network: @church.network, number_of_clergy_employed: @church.number_of_clergy_employed, number_of_staff: @church.number_of_staff, parish: @church.parish, postcode: @church.postcode, start_month: @church.start_month, start_year: @church.start_year, status: @church.status, vacant: @church.vacant }
    assert_redirected_to church_path(assigns(:church))
  end

  test "should destroy church" do
    assert_difference('Church.count', -1) do
      delete :destroy, id: @church
    end

    assert_redirected_to churches_path
  end
end
