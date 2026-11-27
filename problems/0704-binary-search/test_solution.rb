require "minitest/autorun"
require "timeout"
require_relative "solution"

class TestSearch < Minitest::Test
  # 練習のため、配列を前から順に調べるメソッドや、探索してくれるメソッドは使えない
  BANNED = %i[index find_index rindex include? bsearch bsearch_index find detect each each_with_index
              each_index map select filter to_a min max sort dup clone].freeze

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
    actual = Timeout.timeout(2) { search(arr, target) }
    label = nums.size > 20 ? "(長さ #{nums.size} の配列)" : nums.inspect
    assert_equal expected, actual, "nums = #{label}, target = #{target}"
    assert_operator count, :<=, limit,
                    "nums = #{label}, target = #{target}: nums を #{count} 回見ています（O(log n) なら #{limit} 回以内）"
  end

  def test_example_1
    check(4, [-1, 0, 3, 5, 9, 12], 9)
  end

  def test_example_2
    check(-1, [-1, 0, 3, 5, 9, 12], 2)
  end

  def test_single_element
    check(0, [5], 5)
    check(-1, [5], 3)
  end

  def test_first_and_last
    check(0, [1, 3, 5, 7, 9], 1)
    check(4, [1, 3, 5, 7, 9], 9)
  end

  def test_out_of_range
    check(-1, [1, 3, 5, 7, 9], 0)
    check(-1, [1, 3, 5, 7, 9], 10)
  end

  def test_two_elements
    check(0, [2, 4], 2)
    check(1, [2, 4], 4)
    check(-1, [2, 4], 3)
  end

  def test_large_input
    nums = (0...10_000).map { |k| k * 2 - 9_999 }   # -9999, -9997, ..., 9999
    check(0, nums, -9_999)
    check(9_999, nums, 9_999)
    check(6_000, nums, 2_001)
    check(-1, nums, 2_000)
  end
end
