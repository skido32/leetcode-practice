# @param {String} s
# @return {Boolean}
def is_palindrome(s)
  i = 0
  j = s.size - 1
  while i < j
    if s[i].match?(/[0-9A-Za-z]/)
      if s[j].match?(/[0-9A-Za-z]/)
        if s[i].downcase != s[j].downcase
          return false
        end
        i += 1
        j -= 1
      else
        j -= 1
      end
    else
      i += 1
    end
  end
  return true
end
