# @param {Character[]} s
# @return {Void} Do not return anything, modify s in-place instead.
def reverse_string(s)
  (0...s.size/2).each do |i|
    t = s[i]
    s[i] = s[s.size - i - 1]
    s[s.size - i - 1] = t
  end
  s
end
