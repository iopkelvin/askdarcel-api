require 'test_helper'

class ResourcesControllerTest < ActionController::TestCase
  setup do
    @resource = resources(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:resources)
  end

  test "should create resource" do
    assert_difference('Resource.count') do
      post :create, resource: { email: @resource.email, page_id: Resource.count + 1, summary: @resource.summary, title: @resource.title, content: @resource.content }
    end

    assert_response 201
  end

  test "should show resource" do
    get :show, id: @resource
    assert_response :success
  end

  test "should update resource" do
    put :update, id: @resource, resource: { email: @resource.email, page_id: @resource.page_id, summary: @resource.summary, title: @resource.title , content: @resource.content }
    assert_response 204
  end

  test "should destroy resource" do
    assert_difference('Resource.count', -1) do
      delete :destroy, id: @resource
    end

    assert_response 204
  end
end
