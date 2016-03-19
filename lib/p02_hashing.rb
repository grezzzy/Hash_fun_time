class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hash_str = ""
    el_count = 7 # 7 is prime
    # hv = 0
    self.each do |el|
      # hv = el.hash  + i + hash_val
      hash_modulo = el.hash % (el + el_count)
      hash_str << hash_modulo.to_s

      el_count += 1
    end

    hash_str.to_i
  end
end

class String
  def hash
    hash_str = ""
    el_count = 7

    self.split('').each do |el|
      hash_modulo = el.ord.hash % (el.ord * el_count)
      hash_str << hash_modulo.to_s

      el_count += 1
    end

    hash_str.to_i
  end
end
#
# class String
#   def hash
#     hashed = []
#     self.split('').each do |el|
#       hashed << el.ord
#     end
#
#     hashed.join('')
#   end
# end

class Hash
  def hash
    hash_str = ""
    el_count = 7 # unnecessary

    self.to_a.sort.each do |key, value|
      unnecessary_cryptographic_num = el_count * key.to_s.ord * value.to_s.ord

      hash_str << key.to_s + unnecessary_cryptographic_num.to_s
      hash_str << value.to_s + unnecessary_cryptographic_num.to_s

      el_count += 1 # why
    end

    hash_str.hash
  end
end
