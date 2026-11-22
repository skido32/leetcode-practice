require "minitest/autorun"
require "timeout"
require_relative "solution"

class TestContainsDuplicate < Minitest::Test
  def check(expected, nums)
    result = Timeout.timeout(2) { contains_duplicate(nums) }
    refute_nil result, "nil が返っています（まだ未実装？ false を返すべきところで nil になっていない？）"
    assert_equal expected, result
  rescue Timeout::Error
    flunk "2秒以内に終わりませんでした（LeetCode なら Time Limit Exceeded）"
  end

  def test_example_1
    check(true, [1, 2, 3, 1])
  end

  def test_example_2
    check(false, [1, 2, 3, 4])
  end

  def test_example_3
    check(true, [1, 1, 1, 3, 3, 4, 3, 2, 4, 2])
  end

  def test_single_element
    check(false, [7])
  end

  def test_negative_and_zero
    check(true, [-1, 0, 5, -3, 0])
  end

  def test_adjacent_at_end
    check(true, [10, 20, 30, 40, 40])
  end

  def test_large_input_all_different
    check(false, (1..100_000).to_a.reverse)
  end

  def test_large_input_with_one_repeat
    check(true, (1..100_000).to_a + [1])
  end
end
