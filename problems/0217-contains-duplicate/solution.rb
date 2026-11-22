require "set"
# @param {Integer[]} nums
# @return {Boolean}
def contains_duplicate(nums)
  s = Set.new(nums)
  s.size != nums.size
end
