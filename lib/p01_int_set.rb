def reload
  load 'p01_int_set.rb'
end

class MaxIntSet
  def initialize(max)
    @max = max
    @store = Array.new(max, false)
  end

  def error?(num)
    raise "Out of bounds" if num > @max
    raise "Out of bounds" if num < 0
  end

  def insert(num)
    error?(num)
    @store[num] = true
  end

  def remove(num)
    error?(num)
    @store[num] = false
  end

  def include?(num)
    error?(num)
    @store[num]
  end
end

class IntSet
  def initialize(size = 20)
    @store = Array.new(size) { Array.new }
    @size = size
  end

  def insert(num)
    bucket = num % @size
    @store[bucket] << num
  end

  def remove(num)
    bucket = num % @size
    @store[bucket].delete(num)
  end

  def include?(num)
    bucket = num % @size
    @store[bucket].include?(num)
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if @count >= num_buckets
    @count += 1
    bucket = num % num_buckets
    @store[bucket] << num
  end

  def remove(num)
    bucket = num % num_buckets
    @count -= 1
    @store[bucket].delete(num)
  end

  def include?(num)
    bucket = num % num_buckets
    @store[bucket].include?(num)
  end

  def num_buckets
    @store.length
  end

  def resize!
    elements = pull_elements_from_buckets
    num_buckets.times { @store << [] }
    reorder_buckets(elements)
  end

  def pull_elements_from_buckets
    elements = []
    @store.each do |bucket|
      bucket.each do |el|
        elements << self.remove(el)
      end
    end

    elements
  end

  def reorder_buckets(elements)
    elements.each do |element|
      self.insert(element)
    end
  end

end
