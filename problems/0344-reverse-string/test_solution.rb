require "minitest/autorun"
require "timeout"
require_relative "solution"

class TestReverseString < Minitest::Test
  # s そのものが書き換わっているかを確認する（返り値は見ない）
  def check(expected, input)
    s = input.dup
    original_id = s.object_id

    # 練習のため reverse / reverse! を禁止
    def s.reverse(*)
      raise "reverse は使わずに書いてみよう"
    end

    def s.reverse!(*)
      raise "reverse! は使わずに書いてみよう"
    end

    Timeout.timeout(2) { reverse_string(s) }
    assert_equal original_id, s.object_id
    return pass if s == expected

    if s == input
      flunk "渡された配列 s が元のままです（新しい配列を作って返すだけになっていない？）"
    elsif s.size > 20
      diff = (0...s.size).find { |k| s[k] != expected[k] }
      flunk "結果が違います（大きい入力なので一部だけ表示）: #{diff}番目 期待 #{expected[diff].inspect} / 実際 #{s[diff].inspect}"
    else
      assert_equal expected, s
    end
  rescue Timeout::Error
    flunk "2秒以内に終わりませんでした（LeetCode なら Time Limit Exceeded）"
  end

  def test_example_1
    check(%w[o l l e h], %w[h e l l o])
  end

  def test_example_2
    check(%w[h a n n a H], %w[H a n n a h])
  end

  def test_single_char
    check(%w[x], %w[x])
  end

  def test_two_chars
    check(%w[b a], %w[a b])
  end

  def test_even_length
    check(%w[4 3 2 1], %w[1 2 3 4])
  end

  def test_symbols
    check(["!", " ", "?", "#"], ["#", "?", " ", "!"])
  end

  def test_large_input
    input = Array.new(100_000) { |i| (97 + i % 26).chr }
    check(input.reverse, input)
  end
end
