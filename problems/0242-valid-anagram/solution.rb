# @param {String} s
# @param {String} t
# @return {Boolean}
def is_anagram_v1(s, t)
  s_count = Array.new(26,0)
  t_count = Array.new(26,0)
  s.each_char do |ch|
    s_count[ch.ord - "a".ord] = s_count[ch.ord - "a".ord] + 1
  end

  t.each_char do |ch|
    t_count[ch.ord - "a".ord] = t_count[ch.ord - "a".ord] + 1
  end

  s_count == t_count
end

def is_anagram(s, t)
  s_h = {}
  t_h = {}
  s.each_char do |ch|
    if s_h.key?(ch)
      s_h[ch] += 1
    else
      s_h[ch] = 1
    end
  end

  t.each_char do |ch|
    if t_h.key?(ch)
      t_h[ch] += 1
    else
      t_h[ch] = 1
    end
  end

  s_h == t_h
end
