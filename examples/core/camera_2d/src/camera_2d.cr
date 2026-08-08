#
#   Copyright (c) 2016-2025 Ramon Santamaria (@raysan5)
#   Copyright (c) 2026 Devin Shwagginz (@D-Shwagginz)
#

require "raylib-cr"

SCREEN_WIDTH  = 800
SCREEN_HEIGHT = 450
MAX_BUILDINGS = 100

Raylib.init_window(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [core] example - 2d camera")

player = Raylib::Rectangle.new(x: 400, y: 280, width: 40, height: 40)
buildings = Array.new(MAX_BUILDINGS) { Raylib::Rectangle.new(x: 0, y: 0, width: 0, height: 0) }
build_colors = Array.new(MAX_BUILDINGS) { Raylib::Color.new(r: 0, g: 0, b: 0, a: 255) }

spacing = 0

MAX_BUILDINGS.times do |i|
  buildings[i].width = Raylib.get_random_value(50, 200).to_f
  buildings[i].height = Raylib.get_random_value(100, 800).to_f
  buildings[i].y = SCREEN_HEIGHT - 130.0 - buildings[i].height
  buildings[i].x = -6000.0 + spacing

  spacing += buildings[i].width.to_i

  build_colors[i] = Raylib::Color.new(
    r: Raylib.get_random_value(200, 240).to_u8,
    g: Raylib.get_random_value(200, 240).to_u8,
    b: Raylib.get_random_value(200, 250).to_u8,
    a: 255
  )
end

camera = Raylib::Camera2D.new(
  target: Raylib::Vector2.new(x: player.x + 20.0, y: player.y + 20.0),
  offset: Raylib::Vector2.new(x: SCREEN_WIDTH / 2.0, y: SCREEN_HEIGHT / 2.0),
  rotation: 0.0,
  zoom: 1.0
)

Raylib.set_target_fps(60)

until Raylib.close_window?
  if Raylib.key_down?(Raylib::KeyboardKey::Right)
    player.x += 2
  elsif Raylib.key_down?(Raylib::KeyboardKey::Left)
    player.x -= 2
  end

  camera.target = Raylib::Vector2.new(x: player.x + 20, y: player.y + 20)

  if Raylib.key_down?(Raylib::KeyboardKey::A)
    camera.rotation -= 1
  elsif Raylib.key_down?(Raylib::KeyboardKey::S)
    camera.rotation += 1
  end

  camera.rotation = 40 if camera.rotation > 40
  camera.rotation = -40 if camera.rotation < -40

  camera.zoom = Math.exp(Math.log(camera.zoom) + (Raylib.get_mouse_wheel_move * 0.1))
  camera.zoom = 3.0 if camera.zoom > 3.0
  camera.zoom = 0.1 if camera.zoom < 0.1

  if Raylib.key_pressed?(Raylib::KeyboardKey::R)
    camera.zoom = 1.0
    camera.rotation = 0.0
  end

  Raylib.begin_drawing
  Raylib.clear_background(Raylib::RAYWHITE)

  Raylib.begin_mode_2d(camera)

  Raylib.draw_rectangle(-6000, 320, 13000, 8000, Raylib::DARKGRAY)

  buildings.each_with_index do |building, i|
    Raylib.draw_rectangle_rec(building, build_colors[i])
  end

  Raylib.draw_rectangle_rec(player, Raylib::RED)

  Raylib.draw_line(camera.target.x.to_i, -SCREEN_HEIGHT * 10, camera.target.x.to_i, SCREEN_HEIGHT * 10, Raylib::GREEN)
  Raylib.draw_line(-SCREEN_WIDTH * 10, camera.target.y.to_i, SCREEN_WIDTH * 10, camera.target.y.to_i, Raylib::GREEN)

  Raylib.end_mode_2d

  Raylib.draw_text("SCREEN AREA", 640, 10, 20, Raylib::RED)

  Raylib.draw_rectangle(0, 0, SCREEN_WIDTH, 5, Raylib::RED)
  Raylib.draw_rectangle(0, 5, 5, SCREEN_HEIGHT - 10, Raylib::RED)
  Raylib.draw_rectangle(SCREEN_WIDTH - 5, 5, 5, SCREEN_HEIGHT - 10, Raylib::RED)
  Raylib.draw_rectangle(0, SCREEN_HEIGHT - 5, SCREEN_WIDTH, 5, Raylib::RED)

  Raylib.draw_rectangle(10, 10, 250, 113, Raylib.fade(Raylib::SKYBLUE, 0.5))
  Raylib.draw_rectangle_lines(10, 10, 250, 113, Raylib::BLUE)

  Raylib.draw_text("Free 2D camera controls:", 20, 20, 10, Raylib::BLACK)
  Raylib.draw_text("- Right/Left to move player", 40, 40, 10, Raylib::DARKGRAY)
  Raylib.draw_text("- Mouse Wheel to Zoom in-out", 40, 60, 10, Raylib::DARKGRAY)
  Raylib.draw_text("- A / S to Rotate", 40, 80, 10, Raylib::DARKGRAY)
  Raylib.draw_text("- R to reset Zoom and Rotation", 40, 100, 10, Raylib::DARKGRAY)

  Raylib.end_drawing
end

Raylib.close_window
