require "minitest/autorun"
require "timeout"
require_relative "solution"

class TestIsValid < Minitest::Test
  def check(expected, s)
    actual = Timeout.timeout(2) { is_valid(s.dup) }
    label = s.size > 30 ? "(長さ #{s.size} の文字列)" : s.inspect
    assert_equal expected, actual, "s = #{label}"
  end

  def test_examples
    check(true, "()")
    check(true, "()[]{}")
    check(false, "(]")
    check(false, "([)]")
    check(true, "{[]}")
  end

  def test_single_char
    check(false, "(")
    check(false, "]")
  end

  def test_left_over_open
    check(false, "((")
    check(false, "({[")
    check(false, "[](")
  end

  def test_close_first
    check(false, "){")
    check(false, "())(")
    check(false, "]()")
  end

  def test_deep_nesting
    check(true, "{[()()]}([]{})")
    check(false, "{[(])}")
  end

  def test_same_count_wrong_kind
    check(false, "(}")
    check(false, "[(])")
  end

  def test_large_input
    # 長さ 1万
    check(true, "(" * 2500 + "[{" * 1250 + "}]" * 1250 + ")" * 2500)
    check(false, "(" * 5000 + ")" * 4999 + "]")
  end
end
