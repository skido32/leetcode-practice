# @param {String} s
# @return {Boolean}
def is_valid(s)
  open_ch = []
  s.each_char do |ch|
    if ["(","{","["].include?(ch)
      open_ch << ch
    else
      if open_ch.size != 0 
        if ch == ")" && open_ch[-1] == "("
          open_ch.pop
        elsif ch == "}" && open_ch[-1] == "{"
          open_ch.pop
        elsif ch == "]" && open_ch[-1] == "["
          open_ch.pop
        else
          return false
        end
      else
        return false
      end
    end
  end
  if open_ch.size == 0
    return true
  else
    return false
  end
end
