

require 'dxruby'
require 'singleton'

class Player < Sprite
  def initialize x, y
    @costume = {live:Image.new(100, 100, C_WHITE)}
    super x, y, @costume[:live]
  end
  def update
    self.x, self.y = Input.mouse_x, Input.mouse_y
  end
end

class Enemy < Sprite
  def initialize x, y
    @costume = {live:Image.new(20, 20, C_GREEN), dead:Image.new(20, 20, C_RED)}
    super x, y, @costume[:live]
  end
  def update game_objects
    hit_objects = self.check game_objects.select {|obj| obj.instance_of? Player}
    self.image = @costume[:dead] unless hit_objects.empty?
  end
end

player = Player.new Input.mouse_x, Input.mouse_y

enemies = 5.times.map {|enemy|
    Enemy.new rand * 600, rand * 440
}

class Observer
  include Singleton
  attr_reader :game_objects
  def initialize
    @game_objects = []
  end
  def << obj
    if obj.instance_of? Array
      @game_objects.concat obj.flatten.select {|obj| obj.kind_of? Sprite}
    elsif obj.kind_of? Sprite
      @game_objects << obj
    else
      raise "Observer::<<() : arg is NOT Array-class or Sprite-subclass !!"
    end
    self
  end
  def update
    @game_objects.each {|obj|
      next obj.update if obj.method(:update).parameters.length.zero?
      obj.update @game_objects
    }
  end
  def draw
    @game_objects.each {|obj| obj.draw}
  end
end

Observer.instance << player << enemies

Window.width, Window.height = 640, 480


Window.loop do
  break if Input.key_push? K_ESCAPE

  Observer.instance.update
  Observer.instance.draw
end
