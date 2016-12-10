# coding: utf-8

require 'dxruby'
require 'singleton'
require 'observer'

class BulletObserver
  def initialize
    @bullet_container = BulletContainer.instance
  end
  def update bullet
    @bullet_container.bullets.push bullet
  end
end

class BulletContainer
  include Singleton
  attr_accessor :bullets
  def initialize
    @bullets = []
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
    add_observer BulletObserver.new
  end
  def build
    changed true
    notify_observers @obj
    @obj
  end
end

BulletBuilder.new(1, 2, 3, 4).build
BulletBuilder.new(1, 5, 3, 4).build

puts BulletContainer.instance.bullets