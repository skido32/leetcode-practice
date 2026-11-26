class MyQueue
  def initialize()
    @a = []
    @b = []
  end

  # @param {Integer} x
  # @return {Void}
  def push(x)
    @a << x
  end

  # @return {Integer}
  def pop()
    if @b.size == 0
      while @a.size > 1
        @b << @a.pop
      end
      @a.pop
    else
      @b.pop
    end
  end

  # @return {Integer}
  def peek()
    if @b.size == 0
      while @a.size > 0
        @b << @a.pop
      end
    end
    @b.last
  end

  # @return {Boolean}
  def empty()
    @a.size == 0 && @b.size == 0
  end
end
