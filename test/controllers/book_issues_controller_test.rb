require "test_helper"

class BookIssuesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get book_issues_new_url
    assert_response :success
  end
end
