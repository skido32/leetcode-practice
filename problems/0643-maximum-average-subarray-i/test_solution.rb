require "minitest/autorun"
require "timeout"
require_relative "solution"

class TestFindMaxAverage < Minitest::Test
  def check(expected, nums, k)
    actual = Timeout.timeout(2) { find_max_average(nums.dup, k) }
    label = nums.size > 20 ? "(長さ #{nums.size} の配列)" : nums.inspect
    refute_nil actual, "nums = #{label}, k = #{k}: 何も返っていません"
    assert_in_delta expected, actual, 1e-5, "nums = #{label}, k = #{k}"
  end

  def test_example_1
    check(12.75, [1, 12, -5, -6, 50, 3], 4)
  end

  def test_example_2
    check(5.0, [5], 1)
  end

  def test_answer_is_not_whole_number
    check(1.5, [1, 2], 2)
    check(3.5, [3, 1, 4, 1, 5, 2], 2)
  end

  def test_all_negative
    check(-1.5, [-1, -2, -3], 2)
  end

  def test_k_equals_length
    check(2.5, [1, 2, 3, 4], 4)
  end

  def test_best_at_the_end
    check(5.0, [0, 0, 0, 10], 2)
  end

  def test_large_input
    # 10万個、k = 5万。1秒以内（目安）に終わるか
    nums = Array.new(100_000, 0)
    (50_000...100_000).each { |idx| nums[idx] = 1 }
    nums[0] = 10_000
    check(1.0, nums, 50_000)
  end
end
