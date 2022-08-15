class MaxIntSet
  attr_reader :max, :store

  def initialize(max)
    @max = max
    @store = Array.new(@max, false)
  end

  def insert(num)
    if num <= @max && num >= 0
      @store[num] = true
    else
      raise 'Out of bounds'
    end
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    return @store[num]
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    mod = num % num_buckets
    @store[mod] << num
  end

  def remove(num)
    if include?(num)
        @store.each do |bucket|
            if bucket.include?(num)
              bucket.delete(num)
            end
        end
    end
  end

  def include?(num)
    @store.each do |bucket|
      return true if bucket.include?(num)
    end

    false
  end

  private

  def [](num)
    mod = num % num_buckets
    @store[mod]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    return false if include?(num)
    self[num] << num
    @count += 1
    resize! if self.num_buckets < @count
  end

  def remove(num)
    if self.include?(num)
      self[num].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    mod = num % num_buckets
    @store[mod]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @count = 0
    @store = Array.new(num_buckets * 2) { Array.new }

    old_store.flatten.each { |num| insert(num) } 
  end
end
