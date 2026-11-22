# @param {Character[]} s
# @return {Void} Do not return anything, modify s in-place instead.
def reverse_string(s)
  (0...s.size/2).each do |n|
    s[n],s[s.size - 1 - n] = s[s.size - 1 - n],s[n]
  end
end
