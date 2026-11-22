require "minitest/autorun"
require_relative "solution"

class TestTwoSum < Minitest::Test
  # 順番はどちらでもよいので、並べ替えて比較する
  def check(expected, nums, target)
    result = two_sum(nums, target)
    refute_nil result, "nil が返っています（まだ未実装？）"
    assert_equal expected.sort, result.sort
  end

  def test_example_1
    check([0, 1], [2, 7, 11, 15], 9)
  end

  def test_example_2
    check([1, 2], [3, 2, 4], 6)
  end

  def test_example_3
    check([0, 1], [3, 3], 6)
  end

  def test_negative_numbers
    check([2, 4], [-1, -2, -3, -4, -5], -8)
  end

  def test_zero_target
    check([0, 3], [0, 4, 3, 0], 0)
  end

  def test_pair_at_the_end
    check([3, 4], [1, 2, 3, 4, 5], 9)
  end

  def test_large_values
    check([0, 2], [1_000_000_000, 5, -999_999_999], 1)
  end
end
