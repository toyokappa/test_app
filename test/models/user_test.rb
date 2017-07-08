require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(user_name: "test_user",
                     email: "test@test.com",
                     password: "password",
                     password_confirmation: "password")
  end

  test "バリデーション" do
    assert @user.valid?
  end

  test "ユーザー名：存在性" do
    @user.user_name = "    "
    assert_not @user.valid?
  end

  test "ユーザー名：最大文字数" do
    @user.user_name = "a" * 31
    assert_not @user.valid?
  end

  test "ユーザー名：一意性" do
    dup_user = @user.dup
    dup_user.user_name = @user.user_name.upcase
    @user.save
    assert_not dup_user.valid?
  end

  test "ユーザー名：有効なフォーマット" do
    valid_user_names = %w[yutachan taro2 3Shiro Boys2Men]
    valid_user_names.each do |valid_user_name|
      @user.user_name = valid_user_name
      assert @user.valid?, "#{valid_user_name.inspect}は使用可能"
    end
  end

  test "ユーザー名：無効なフォーマット" do
    invalid_user_names = %w[yuta-chan Taro@San 3.sHiro boY.2/meN あいう]
    invalid_user_names.each do |invalid_user_name|
      @user.user_name = invalid_user_name
      assert_not @user.valid?, "#{invalid_user_name.inspect}は使用不可"
    end
  end

  test "メールアドレス：存在性" do
    @user.email = "    "
    assert_not @user.valid?
  end

  test "メールアドレス：最大文字数" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "メールアドレス：一意性" do
    dup_user = @user.dup
    dup_user.email = @user.email.upcase
    @user.save
    assert_not dup_user.valid?
  end

  test "メールアドレス：有効なフォーマット" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "メールアドレス：無効なフォーマット" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "メールアドレス：保存前に小文字化する" do
    mixed_case_email = "Foo@ExaMple.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "パスワード：存在性（空欄不可）" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "パスワード：最小文字数" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end
