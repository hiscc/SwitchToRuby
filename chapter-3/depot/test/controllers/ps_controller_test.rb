require 'test_helper'

class PsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @p = ps(:one)
  end

  test "should get index" do
    get ps_url
    assert_response :success
  end

  test "should get new" do
    get new_p_url
    assert_response :success
  end

  test "should create p" do
    assert_difference('P.count') do
      post ps_url, params: { p: { description: @p.description, image_url: @p.image_url, price: @p.price, title: @p.title } }
    end

    assert_redirected_to p_url(P.last)
  end

  test "should show p" do
    get p_url(@p)
    assert_response :success
  end

  test "should get edit" do
    get edit_p_url(@p)
    assert_response :success
  end

  test "should update p" do
    patch p_url(@p), params: { p: { description: @p.description, image_url: @p.image_url, price: @p.price, title: @p.title } }
    assert_redirected_to p_url(@p)
  end

  test "should destroy p" do
    assert_difference('P.count', -1) do
      delete p_url(@p)
    end

    assert_redirected_to ps_url
  end
end
