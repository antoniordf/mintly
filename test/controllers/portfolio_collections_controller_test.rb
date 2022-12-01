require "test_helper"

class PortfolioCollectionsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get portfolio_collections_create_url
    assert_response :success
  end
end
