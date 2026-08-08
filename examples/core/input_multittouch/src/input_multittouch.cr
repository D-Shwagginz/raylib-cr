#
#   Copyright (c) 2019-2025 Berni (@Berni8k) and Ramon Santamaria (@raysan5)
#   Copyright (c) 2026 Devin Shwagginz (@D-Shwagginz)
#

require "raylib-cr"

SCREEN_WIDTH  = 800
SCREEN_HEIGHT = 450

Raylib.init_window(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [core] example - input multitouch")
Raylib.set_target_fps(60) # Set our game to run at 60 frames-per-second

until Raylib.close_window?
  touch_count = Raylib.get_touch_point_count
  touch_count = 10 if touch_count > 10

  touch_positions = Array.new(touch_count) { Raylib::Vector2.new(x: 0.0, y: 0.0) }
  (0...touch_count).each do |i|
    touch_positions[i] = Raylib.get_touch_position(i)
  end

  Raylib.begin_drawing
  Raylib.clear_background(Raylib::RAYWHITE)

  touch_positions.each_with_index do |pos, i|
    if pos.x > 0 && pos.y > 0
      Raylib.draw_circle_v(pos, 34, Raylib::ORANGE)
      Raylib.draw_text(i.to_s, pos.x.to_i - 10, pos.y.to_i - 70, 40, Raylib::BLACK)
    end
  end

  Raylib.draw_text("touch the screen at multiple locations to get multiple balls", 10, 10, 20, Raylib::DARKGRAY)
  Raylib.end_drawing
end

Raylib.close_window
