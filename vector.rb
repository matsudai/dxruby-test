

class Vector
  attr_reader :x, :y
  def initialize x, y
    @x, @y = x, y
  end
  def + v
    raise "Vector::+() : arg is NOT Vector-class !!" unless v.instance_of? Vector
    Vector.new @x + v.x, @y + v.y
  end
  def to_s
    "(#{@x}, #{@y})"
  end
  def length
    Math.sqrt @x**2 + @y**2
  end
end

v1, v2 = Vector.new(1, 2), Vector.new(2, 3)
v3 = v1 + v2

puts v1.length
puts v1.to_s
puts ""
puts v1
puts v2
puts v3
