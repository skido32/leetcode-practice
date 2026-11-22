require "minitest/autorun"
require "timeout"
require_relative "solution"

class TestValidAnagram < Minitest::Test
  def check(expected, s, t)
    result = Timeout.timeout(2) { is_anagram(s, t) }
    refute_nil result, "nil が返っています（まだ未実装？ false を返すべきところで nil になっていない？）"
    assert_equal expected, result
  rescue Timeout::Error
    flunk "2秒以内に終わりませんでした（LeetCode なら Time Limit Exceeded）"
  end

  def test_example_1
    check(true, "anagram", "nagaram")
  end

  def test_example_2
    check(false, "rat", "car")
  end

  def test_single_char_same
    check(true, "a", "a")
  end

  def test_different_length
    check(false, "ab", "abb")
  end

  def test_same_letters_different_counts
    check(false, "aacc", "ccac")
  end

  def test_identical_strings
    check(true, "listen", "listen")
  end

  def test_large_input_true
    base = ("a".."z").to_a.join * 1923 # 長さ 49998
    check(true, base, base.reverse)
  end

  def test_large_input_false
    base = ("a".."z").to_a.join * 1923
    check(false, base, base.reverse.sub("z", "y"))
  end

  # ---- 発展: Unicode ----
  def test_unicode_hiragana
    check(true, "あいう", "うあい")
  end

  def test_unicode_kanji_false
    check(false, "日本語", "日本人")
  end

  def test_unicode_emoji
    check(true, "🍎🍌🍎", "🍌🍎🍎")
  end

  def test_unicode_mixed
    check(true, "aあ1", "1aあ")
  end

  def test_unicode_counts_differ
    check(false, "ああい", "あいい")
  end
end
