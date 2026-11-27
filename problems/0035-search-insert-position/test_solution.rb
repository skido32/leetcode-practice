require "minitest/autorun"
require "timeout"
require_relative "solution"

class TestSearchInsert < Minitest::Test
  # 練習のため、配列を前から順に調べるメソッドや、探索してくれるメソッドは使えない
  BANNED = %i[index find_index rindex include? bsearch bsearch_index find detect each each_with_index
              each_index map select filter to_a min max sort count dup clone slice].freeze

  # nums を見る回数（nums[i]）を数え、O(log n) かどうか確かめる
  def check(expected, nums, target)
    arr = nums.dup
    count = 0
    BANNED.each do |m|
      arr.define_singleton_method(m) { |*| raise "練習のため nums に #{m} は使わずに書いてみよう" }
    end
    arr.define_singleton_method(:[]) do |*args|
      count += 1
      super(*args)
    end
    limit = 2 * Math.log2(nums.size + 1).ceil + 4
    actual = Timeout.timeout(2) { search_insert(arr, target) }
    label = nums.size > 20 ? "(長さ #{nums.size} の配列)" : nums.inspect
    assert_equal expected, actual, "nums = #{label}, target = #{target}"
    assert_operator count, :<=, limit,
                    "nums = #{label}, target = #{target}: nums を #{count} 回見ています（O(log n) なら #{limit} 回以内）"
  end

  def test_examples
    check(2, [1, 3, 5, 6], 5)
    check(1, [1, 3, 5, 6], 2)
    check(4, [1, 3, 5, 6], 7)
  end

  def test_before_first
    check(0, [1, 3, 5, 6], 0)
    check(0, [1, 3, 5, 6], -100)
  end

  def test_single_element
    check(0, [5], 5)
    check(0, [5], 4)
    check(1, [5], 6)
  end

  def test_two_elements
    check(0, [2, 4], 1)
    check(1, [2, 4], 3)
    check(2, [2, 4], 5)
    check(1, [2, 4], 4)
  end

  def test_negative_numbers
    check(2, [-7, -3, 0, 8], -1)
    check(1, [-7, -3, 0, 8], -3)
  end

  def test_every_gap
    nums = [10, 20, 30, 40, 50, 60, 70]
    [5, 15, 25, 35, 45, 55, 65, 75].each_with_index do |t, k|
      check(k, nums, t)
    end
  end

  def test_large_input
    nums = (0...10_000).map { |k| k * 2 }   # 0, 2, 4, ..., 19998
    check(0, nums, -1)
    check(10_000, nums, 20_000)
    check(3_000, nums, 6_000)
    check(3_001, nums, 6_001)
  end
end
