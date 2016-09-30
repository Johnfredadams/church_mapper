require 'test_helper'

class AddressesPeopleControllerTest < ActionController::TestCase
  setup do
    @addresses_person = addresses_people(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:addresses_people)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create addresses_person" do
    assert_difference('AddressesPerson.count') do
      post :create, addresses_person: { address_id: @addresses_person.address_id, person_id: @addresses_person.person_id }
    end

    assert_redirected_to addresses_person_path(assigns(:addresses_person))
  end

  test "should show addresses_person" do
    get :show, id: @addresses_person
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @addresses_person
    assert_response :success
  end

  test "should update addresses_person" do
    patch :update, id: @addresses_person, addresses_person: { address_id: @addresses_person.address_id, person_id: @addresses_person.person_id }
    assert_redirected_to addresses_person_path(assigns(:addresses_person))
  end

  test "should destroy addresses_person" do
    assert_difference('AddressesPerson.count', -1) do
      delete :destroy, id: @addresses_person
    end

    assert_redirected_to addresses_people_path
  end
end
