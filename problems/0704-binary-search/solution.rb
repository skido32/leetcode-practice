# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer}
def search(nums, target)
  left = 0 
  right = nums.size-1
  while left <= right
    mid = (left + right) / 2
    if nums[mid] == target
      return mid
    elsif nums[mid] > target
      right = mid - 1
    else
      left = mid + 1
    end
  end
  return -1
end
