require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count >= num_buckets
    @count += 1
    @store[get_index(key)] << key
  end

  def remove(key)
    @count -= 1
    @store[get_index(key)].delete(key)
  end

  def include?(key)
    @store[get_index(key)].include?(key)
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

  def get_index(key)
    key.hash % num_buckets
  end
end
