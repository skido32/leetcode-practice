# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer[]}
def two_sum(nums, target)
  hash = {}
  nums.each_with_index do |num,i|
    diff = target - num
    if hash.key?(diff)
      return [i,hash[diff]]
    else
      hash[num] = i
    end
  end
end
