# @param {Integer[]} nums
# @param {Integer} k
# @return {Float}
def find_max_average(nums, k)
  total = 0
  (0..k - 1).each do |n|
    total += nums[n]
  end
  max_total = total

  if nums.size > 1
    (1..nums.size - k).each do |n|
      total += nums[n + k - 1] - nums[n - 1]
      if total > max_total
        max_total = total
      end
    end
    return max_total / k.to_f
  else
    return max_total / k.to_f
  end
end
