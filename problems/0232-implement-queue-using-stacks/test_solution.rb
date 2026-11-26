require "minitest/autorun"
require "timeout"
require_relative "solution"

class TestMyQueue < Minitest::Test
  # スタックとして使えない配列の操作（先頭や途中を触るもの）
  BANNED = %i[shift unshift prepend first insert delete_at delete slice slice! rotate rotate!
              reverse reverse! values_at take drop dig each each_with_index map map! sort sort!
              min sum to_a dup clone + concat replace].freeze

  def new_queue
    q = MyQueue.new
    lock_stacks(q)
    q
  end

  # MyQueue の中で使っている配列に、スタックの操作だけを許可する
  def lock_stacks(q)
    arrays = q.instance_variables.map { |v| q.instance_variable_get(v) }.select { |a| a.is_a?(Array) }
    assert_operator arrays.size, :>=, 1, "initialize の中で、スタック用の配列をインスタンス変数（@ で始まる）に入れよう"
    arrays.each do |a|
      BANNED.each do |m|
        a.define_singleton_method(m) { |*| raise "練習のため、スタックに #{m} は使えません（使えるのは push / << / pop / last / [-1] / size / empty?）" }
      end
      a.define_singleton_method(:[]) do |*args|
        raise "練習のため、スタックは [-1]（一番上）しか見られません（#{args.inspect} が使われた）" unless args == [-1]
        super(*args)
      end
      a.define_singleton_method(:[]=) { |*| raise "練習のため、スタックに []= は使えません（push / << で積もう）" }
    end
  end

  def test_example
    q = new_queue
    q.push(1)
    q.push(2)
    assert_equal 1, q.peek
    assert_equal 1, q.pop
    assert_equal false, q.empty
  end

  def test_empty_at_start_and_after_pop_all
    q = new_queue
    assert_equal true, q.empty
    q.push(5)
    assert_equal false, q.empty
    assert_equal 5, q.pop
    assert_equal true, q.empty
  end

  def test_order_is_first_in_first_out
    q = new_queue
    [3, 1, 4, 1, 5].each { |x| q.push(x) }
    assert_equal [3, 1, 4, 1, 5], Array.new(5) { q.pop }
    assert_equal true, q.empty
  end

  def test_peek_does_not_remove
    q = new_queue
    q.push(7)
    q.push(8)
    assert_equal 7, q.peek
    assert_equal 7, q.peek
    assert_equal 7, q.pop
    assert_equal 8, q.peek
  end

  def test_push_after_pop
    q = new_queue
    q.push(1)
    q.push(2)
    assert_equal 1, q.pop
    q.push(3)
    q.push(4)
    assert_equal 2, q.pop
    assert_equal 3, q.peek
    q.push(5)
    assert_equal [3, 4, 5], Array.new(3) { q.pop }
    assert_equal true, q.empty
  end

  def test_random_operations
    rng = Random.new(232)
    q = new_queue
    expected = []
    300.times do
      case rng.rand(4)
      when 0, 1
        x = rng.rand(1..9)
        q.push(x)
        expected << x
      when 2
        next if expected.empty?
        assert_equal expected.shift, q.pop
      else
        next if expected.empty?
        assert_equal expected[0], q.peek
      end
      assert_equal expected.empty?, q.empty
    end
  end

  def test_many_operations_followup
    # 発展: 5万個入れてから「取り出す → 入れる」を5万回。各操作がならして O(1) なら一瞬で終わる
    Timeout.timeout(2) do
      q = new_queue
      (1..50_000).each { |x| q.push(x % 9 + 1) }
      50_000.times do |k|
        assert_equal (k + 1) % 9 + 1, q.pop
        q.push(1)
      end
    end
  rescue Timeout::Error
    flunk "（発展）2秒以内に終わりませんでした。pop / peek のたびに、全部を移し替えていませんか？"
  end

end
