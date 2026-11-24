require "minitest/autorun"
require "timeout"
require_relative "solution"

class TestMaxProfit < Minitest::Test
  def check(expected, prices)
    actual = Timeout.timeout(2) { max_profit(prices.dup) }
    assert_equal expected, actual, "prices = #{prices.size > 20 ? "(長さ #{prices.size} の配列)" : prices.inspect}"
  end

  def test_example_1
    check(5, [7, 1, 5, 3, 6, 4])
  end

  def test_example_2
    check(0, [7, 6, 4, 3, 1])
  end

  def test_single_day
    check(0, [5])
  end

  def test_two_days
    check(1, [1, 2])
    check(0, [2, 1])
  end

  def test_all_same
    check(0, [3, 3, 3, 3])
  end

  def test_lowest_comes_late
    check(4, [4, 6, 1, 5])
    check(6, [2, 4, 1, 7])
  end

  def test_large_input
    # 10万日分。1秒以内（目安）に終わるか
    prices = (0...100_000).map { |k| 100_000 - k }   # ずっと値下がり
    prices[-1] = 100_000                              # 最終日だけ急騰
    check(100_000 - 2, prices)
  end
end
