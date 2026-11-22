require "minitest/autorun"
require "timeout"
require_relative "solution"

class TestValidPalindrome < Minitest::Test
  # 発展（追加メモリ O(1)）: s 全体から新しい文字列・配列を作るメソッドを禁止
  # （s[i].downcase のように1文字ずつ使うのは OK）
  BANNED = %i[downcase downcase! upcase upcase! gsub gsub! delete delete!
              reverse reverse! chars split scan tr tr! squeeze swapcase].freeze

  def check(expected, s)
    s = s.dup
    BANNED.each do |m|
      s.define_singleton_method(m) do |*|
        raise "発展版: s 全体に #{m} を使うと新しい文字列ができて O(n) になります（1文字ずつなら OK）"
      end
    end
    result = Timeout.timeout(2) { is_palindrome(s) }
    refute_nil result, "nil が返っています（まだ未実装？ false を返すべきところで nil になっていない？）"
    assert_equal expected, result, "入力: #{s.size > 40 ? s[0, 40] + '...' : s.inspect}"
  rescue Timeout::Error
    flunk "2秒以内に終わりませんでした（LeetCode なら Time Limit Exceeded）"
  end

  def test_example_1
    check(true, "A man, a plan, a canal: Panama")
  end

  def test_example_2
    check(false, "race a car")
  end

  def test_example_3
    check(true, " ")
  end

  def test_digit_and_letter
    check(false, "0P")
  end

  def test_upper_and_lower
    check(true, "Aa")
  end

  def test_only_symbols
    check(true, ".,!?")
  end

  def test_underscore_is_ignored
    check(true, "ab_a")
  end

  def test_large_input
    half = Array.new(100_000) { |i| (97 + i % 26).chr }.join
    check(true, half + half.reverse)
  end
end
