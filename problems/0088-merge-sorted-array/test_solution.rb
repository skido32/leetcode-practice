require "minitest/autorun"
require_relative "solution"

class TestMergeSortedArray < Minitest::Test
  # 練習のため、並べ替え・丸ごと置き換え系のメソッドを nums1 に使えないようにする
  BANNED = %i[sort sort! sort_by sort_by! replace concat + dup clone].freeze

  # nums1 そのものが書き換わっているかを確認する（返り値は見ない）
  def check(expected, nums1_input, m, nums2, n)
    nums1 = nums1_input.dup
    original_id = nums1.object_id
    BANNED.each do |meth|
      nums1.define_singleton_method(meth) do |*|
        raise "練習のため nums1 に #{meth} は使わずに書いてみよう"
      end
    end

    merge(nums1, m, nums2.dup, n)

    assert_equal original_id, nums1.object_id
    assert_equal m + n, nums1.size,
                 "nums1 の長さが変わっています（m + n = #{m + n} のままにする）: #{nums1.inspect}"
    return pass if nums1 == expected

    if nums1 == nums1_input
      flunk "nums1 が元のままです（新しい配列を作って返すだけになっていない？）"
    else
      assert_equal expected, nums1
    end
  end

  def test_example_1
    check([1, 2, 2, 3, 5, 6], [1, 2, 3, 0, 0, 0], 3, [2, 5, 6], 3)
  end

  def test_example_2
    check([1], [1], 1, [], 0)
  end

  def test_example_3
    check([1], [0], 0, [1], 1)
  end

  def test_second_all_smaller
    check([1, 2, 3, 4, 5, 6], [4, 5, 6, 0, 0, 0], 3, [1, 2, 3], 3)
  end

  def test_alternating
    check([1, 2, 3, 4, 5, 6], [1, 3, 5, 0, 0, 0], 3, [2, 4, 6], 3)
  end

  def test_negatives_and_duplicates
    check([-1, 0, 0, 1, 2, 2, 3, 3, 3],
          [-1, 0, 0, 3, 3, 3, 0, 0, 0], 6, [1, 2, 2], 3)
  end

  def test_different_lengths
    check([-5, 1, 2, 7, 8, 10, 20], [1, 7, 10, 20, 0, 0, 0], 4, [-5, 2, 8], 3)
  end
end
