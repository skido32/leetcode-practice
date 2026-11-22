# @param {String} s
# @return {Boolean}
def is_palindrome_v1(s)
  r = s.downcase.gsub(/[^a-z0-9]/, "")
  r == r.reverse
end

def is_palindrome(s)
  left = 0
  right = s.size - 1
  while left < right
    if s[left].match?(/[^a-zA-Z0-9]/)
      left += 1
    elsif s[right].match?(/[^a-zA-Z0-9]/)
      right -= 1
    else
      if s[left].downcase == s[right].downcase
        left += 1
        right -= 1
      else
        return false
      end
    end
  end
  return true
end
