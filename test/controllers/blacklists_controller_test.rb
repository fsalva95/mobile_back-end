require 'test_helper'

class BlacklistsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @blacklist = blacklists(:one)
  end

  test "should get index" do
    get blacklists_url, as: :json
    assert_response :success
  end

  test "should create blacklist" do
    assert_difference('Blacklist.count') do
      post blacklists_url, params: { blacklist: { token: @blacklist.token } }, as: :json
    end

    assert_response 201
  end

  test "should show blacklist" do
    get blacklist_url(@blacklist), as: :json
    assert_response :success
  end

  test "should update blacklist" do
    patch blacklist_url(@blacklist), params: { blacklist: { token: @blacklist.token } }, as: :json
    assert_response 200
  end

  test "should destroy blacklist" do
    assert_difference('Blacklist.count', -1) do
      delete blacklist_url(@blacklist), as: :json
    end

    assert_response 204
  end
end
