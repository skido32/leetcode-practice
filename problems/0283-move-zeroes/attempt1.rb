# @param {Integer[]} nums
# @return {Void} Do not return anything, modify nums in-place instead.
def move_zeroes(nums)
  i = 0
  j = 0
  while j < nums.size
    if nums[j] != 0
      nums[i], nums[j] = nums[j], nums[i] if i != j
      i += 1
    end
    j += 1
  end
end
