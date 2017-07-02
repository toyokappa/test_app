require "test_helper"

class ApplicationHelperTest < ActionView::TestCase

  test "full_titleヘルパーのテスト" do
    assert_equal full_title, "Knowledge Stocker"
    assert_equal full_title("About"), "About | Knowledge Stocker"
  end
end
