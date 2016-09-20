require 'test_helper'

class ChurchesPeopleControllerTest < ActionController::TestCase
  setup do
    @churches_person = churches_people(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:churches_people)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create churches_person" do
    assert_difference('ChurchesPerson.count') do
      post :create, churches_person: { church_id: @churches_person.church_id, end_date_day: @churches_person.end_date_day, end_date_month: @churches_person.end_date_month, end_date_year: @churches_person.end_date_year, person_id: @churches_person.person_id, start_date_day: @churches_person.start_date_day, start_date_month: @churches_person.start_date_month, start_date_year: @churches_person.start_date_year }
    end

    assert_redirected_to churches_person_path(assigns(:churches_person))
  end

  test "should show churches_person" do
    get :show, id: @churches_person
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @churches_person
    assert_response :success
  end

  test "should update churches_person" do
    patch :update, id: @churches_person, churches_person: { church_id: @churches_person.church_id, end_date_day: @churches_person.end_date_day, end_date_month: @churches_person.end_date_month, end_date_year: @churches_person.end_date_year, person_id: @churches_person.person_id, start_date_day: @churches_person.start_date_day, start_date_month: @churches_person.start_date_month, start_date_year: @churches_person.start_date_year }
    assert_redirected_to churches_person_path(assigns(:churches_person))
  end

  test "should destroy churches_person" do
    assert_difference('ChurchesPerson.count', -1) do
      delete :destroy, id: @churches_person
    end

    assert_redirected_to churches_people_path
  end
end
