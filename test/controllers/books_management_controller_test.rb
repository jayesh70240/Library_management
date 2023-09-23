require "test_helper"

class BooksManagementControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get books_management_index_url
    assert_response :success
  end
end
