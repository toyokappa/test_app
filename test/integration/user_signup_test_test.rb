require 'test_helper'

class UsersSignupTestTest < ActionDispatch::IntegrationTest

  test "登録失敗時のテスト" do
    get signup_path
    assert_no_difference "User.count" do
      post signup_path, params: { user: { user_name: " ",
                                         email: "invalid@email",
                                         password: "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template "users/new"
    assert_match "入力エラー：5項目", response.body
  end

  test "登録成功時のテスト" do
    get signup_path
    assert_difference "User.count", 1 do
      post signup_path, params: { user: { user_name: "test_user",
                                          email: "test@test.com",
                                          password: "password",
                                          password_confirmation: "password" }}
    end
    follow_redirect!
    assert_template "users/show"
    assert_not flash.empty?
    assert_match "ユーザー登録が完了しました！", response.body
  end
end
