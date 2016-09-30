require 'test_helper'

class AddressPeopleControllerTest < ActionController::TestCase
  setup do
    @address_person = address_people(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:address_people)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create address_person" do
    assert_difference('AddressPerson.count') do
      post :create, address_person: { address_id: @address_person.address_id, person_id: @address_person.person_id }
    end

    assert_redirected_to address_person_path(assigns(:address_person))
  end

  test "should show address_person" do
    get :show, id: @address_person
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @address_person
    assert_response :success
  end

  test "should update address_person" do
    patch :update, id: @address_person, address_person: { address_id: @address_person.address_id, person_id: @address_person.person_id }
    assert_redirected_to address_person_path(assigns(:address_person))
  end

  test "should destroy address_person" do
    assert_difference('AddressPerson.count', -1) do
      delete :destroy, id: @address_person
    end

    assert_redirected_to address_people_path
  end
end
