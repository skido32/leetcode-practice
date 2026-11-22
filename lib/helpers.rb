# LeetCode と同じ定義の ListNode / TreeNode と、テスト用の変換ヘルパ

class ListNode
  attr_accessor :val, :next

  def initialize(val = 0, _next = nil)
    @val = val
    @next = _next
  end
end

class TreeNode
  attr_accessor :val, :left, :right

  def initialize(val = 0, left = nil, right = nil)
    @val = val
    @left = left
    @right = right
  end
end

module Helpers
  module_function

  # [1, 2, 3] -> 1 -> 2 -> 3
  def build_list(arr)
    dummy = ListNode.new
    cur = dummy
    arr.each do |v|
      cur.next = ListNode.new(v)
      cur = cur.next
    end
    dummy.next
  end

  # 1 -> 2 -> 3 -> [1, 2, 3]
  def list_to_a(head)
    out = []
    while head
      out << head.val
      head = head.next
    end
    out
  end

  # LeetCode のレベル順配列表記 [3, 9, 20, nil, nil, 15, 7] から木を作る
  def build_tree(arr)
    return nil if arr.empty? || arr[0].nil?

    root = TreeNode.new(arr[0])
    queue = [root]
    i = 1
    until queue.empty? || i >= arr.size
      node = queue.shift
      [:left=, :right=].each do |setter|
        break if i >= arr.size

        unless arr[i].nil?
          child = TreeNode.new(arr[i])
          node.send(setter, child)
          queue << child
        end
        i += 1
      end
    end
    root
  end

  # 木 -> LeetCode のレベル順配列表記（末尾の nil は削る）
  def tree_to_a(root)
    out = []
    queue = [root]
    until queue.empty?
      node = queue.shift
      if node
        out << node.val
        queue << node.left << node.right
      else
        out << nil
      end
    end
    out.pop while !out.empty? && out.last.nil?
    out
  end
end
