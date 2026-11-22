# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer[]}
def two_sum_v1(nums, target)
  nums.each_with_index do |num,index|
    diff = target - num
    diff_index = nums.index(diff)
    if index != diff_index && diff_index != nil
      return [index,diff_index]
    end
  end
end

def two_sum(nums, target)
  h = {}
  nums.each_with_index do |num,index|
    h[num] = index
  end

  nums.each_with_index do |num,index|
    diff = target - num
    diff_index = h[diff]
    if index != diff_index && diff_index != nil
      return [index,diff_index]
    end
  end
end
