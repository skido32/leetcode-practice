# @param {Integer[]} prices
# @return {Integer}
def max_profit(prices)
  min_price = prices[0]
  m_profit = 0
  prices.each do |price|
    if price - min_price > m_profit
      m_profit = price - min_price
    end
    if min_price > price
      min_price = price
    end
  end
  return m_profit
end
