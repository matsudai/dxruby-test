# coding: utf-8

require 'dxruby'
require 'singleton'
require 'observer'

class BulletObserver
  include Singleton
  attr_accessor :bullets
  def initialize
    @bullets = []
  end
  def update bullet
    @bullets.push bullet
  end
end

class Bullet
  attr_accessor :position, :velocity
  def initialize p, v
    @position, @velocity = p, v
  end
end

class BulletBuilder
  include Observable
  def initialize x, y, speed_x, speed_y
    position = Complex x, y
    velocity = Complex speed_x, speed_y
    @obj = Bullet.new position, velocity
    add_observer BulletObserver.instance
  end
  def build
    changed true
    notify_observers @obj
    @obj
  end
end

BulletBuilder.new(1, 2, 3, 4).build
BulletBuilder.new(1, 5, 3, 4).build

puts BulletObserver.instance.bullets