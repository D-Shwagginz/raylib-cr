class Wireland::Component::Start < Wireland::Component
  def self.allow_adjacent?
    true
  end

  def on_tick
    if parent.ticks < xy.size
      parent.active_pulse(id, connects.dup)
    end
  end
end
