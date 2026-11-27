# @param {Integer[]} prices
# @return {Integer}
def max_profit(prices)
  low_price = prices[0]
  max = 0
  prices.each do |p|
    if max < p - low_price
      max = p - low_price
    end
    if low_price > p
      low_price = p
    end
  end
  return max
end
