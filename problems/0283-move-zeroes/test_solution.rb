require "minitest/autorun"
require "timeout"
require_relative "solution"

class TestMoveZeroes < Minitest::Test
  # 練習のため、配列をまとめて処理するメソッドを nums に使えないようにする
  BANNED = %i[sort sort! sort_by sort_by! select select! filter filter! reject reject!
              delete delete_if keep_if partition compact compact! map map! collect collect!
              dup clone + - replace concat rotate rotate! reverse reverse! uniq uniq!].freeze

  # nums そのものが書き換わっているかを確認する（返り値は見ない）
  def check(expected, input)
    nums = input.dup
    original_id = nums.object_id
    BANNED.each do |m|
      nums.define_singleton_method(m) do |*|
        raise "練習のため nums に #{m} は使わずに書いてみよう"
      end
    end

    Timeout.timeout(2) { move_zeroes(nums) }
    assert_equal original_id, nums.object_id
    return pass if nums == expected

    if nums == input
      flunk "渡された配列 nums が元のままです（新しい配列を作って返すだけになっていない？）"
    elsif nums.size > 20
      diff = (0...nums.size).find { |k| nums[k] != expected[k] }
      msg = diff ? "#{diff}番目 期待 #{expected[diff].inspect} / 実際 #{nums[diff].inspect}" : "長さが違います（期待 #{expected.size} / 実際 #{nums.size}）"
      flunk "結果が違います（大きい入力なので一部だけ表示）: #{msg}"
    else
      assert_equal expected, nums
    end
  rescue Timeout::Error
    flunk "2秒以内に終わりませんでした（LeetCode なら Time Limit Exceeded）"
  end

  def test_example_1
    check([1, 3, 12, 0, 0], [0, 1, 0, 3, 12])
  end

  def test_example_2
    check([0], [0])
  end

  def test_no_zeroes
    check([1, 2, 3], [1, 2, 3])
  end

  def test_all_zeroes
    check([0, 0, 0], [0, 0, 0])
  end

  def test_zeroes_already_at_end
    check([4, 5, 0, 0], [4, 5, 0, 0])
  end

  def test_negative_and_consecutive_zeroes
    check([-1, 2, -3, 0, 0, 0], [0, 0, -1, 2, 0, -3])
  end

  def test_large_input
    input = Array.new(10_000) { |i| i.even? ? 0 : i }
    expected = input.select { |x| x != 0 } + Array.new(5_000, 0)
    check(expected, input)
  end
end
