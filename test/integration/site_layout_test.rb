require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "Homeのレイアウトのテスト" do
    get root_path
    assert_template "static_pages/home"
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", signup_path, count: 2
    get about_path
    assert_select "title", full_title("About")
  end
end
