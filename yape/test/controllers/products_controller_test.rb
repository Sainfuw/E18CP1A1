require 'test_helper'

  # t.string "name"
  # t.text "description"
  # t.integer "price"
  # t.integer "user_id"|
  # t.datetime "created_at", null: false
  # t.datetime "updated_at", null: false

class ProductsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @user = users(:one)
    @product = products(:one)
    @newproduct = {
                    :name         => 'auto',
                    :description  => 'auto',
                    :price        => 2,
                    :user_id      => @user.id
                  }
  end

  test "should get index" do
    get products_url
    assert_response :success
  end

  test "all can show products" do
    get product_url(@product)
    assert_response :success
  end

  test "owner can edit a product" do
    sign_in @user
    # sign_out :user
    get edit_product_url(@product)
    assert_response :success
  end

  test "users can resgistrate new product" do
    sign_in @user
    # sign_out :user
    get new_product_url
    assert_response :success
  end

  test "users should create product" do
    sign_in @user
    # sign_out :user
    assert_difference('Product.count') do
      post products_url, params: { product: @newproduct }
    end
    assert_redirected_to product_url(Product.last)
  end

  test "owner should update product" do
    sign_in @user
    # sign_out :user
    patch product_url(@product), params: { product: @newproduct }
    assert_redirected_to product_url(@product)
  end

  test "should destroy product" do
    sign_in @user
    # sign_out :user
    assert_difference('Product.count', -1) do
      delete product_url(@product)
    end
    assert_redirected_to products_url
  end
end
