#
#   Copyright (c) 2013-2025 Ramon Santamaria (@raysan5)
#   Copyright (c) 2026 Devin Shwagginz (@D-Shwagginz)
#

require "raylib-cr"

SCREEN_WIDTH  = 800
SCREEN_HEIGHT = 450

XBOX_ALIAS_1 = "xbox"
XBOX_ALIAS_2 = "x-box"
PS_ALIAS_1   = "playstation"
PS_ALIAS_2   = "sony"

Raylib.init_window(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [core] example - input gamepad")

tex_ps3_pad = Raylib.load_texture("resources/ps3.png")
tex_xbox_pad = Raylib.load_texture("resources/xbox.png")

left_stick_deadzone_x = 0.1
left_stick_deadzone_y = 0.1
right_stick_deadzone_x = 0.1
right_stick_deadzone_y = 0.1
left_trigger_deadzone = -0.9
right_trigger_deadzone = -0.9

vibrate_button = Raylib::Rectangle.new(x: 0, y: 0, width: 75, height: 24)

Raylib.set_target_fps(60) # Set our game to run at 60 frames-per-second

gamepad = 0

until Raylib.close_window?
  if Raylib.key_pressed?(Raylib::KeyboardKey::Left) && gamepad > 0
    gamepad -= 1
  end

  if Raylib.key_pressed?(Raylib::KeyboardKey::Right)
    gamepad += 1
  end

  mouse_position = Raylib.get_mouse_position

  vibrate_button = Raylib::Rectangle.new(
    x: 10,
    y: 70.0 + 20 * Raylib.get_gamepad_axis_count(gamepad) + 20,
    width: 75,
    height: 24
  )

  if Raylib.mouse_button_pressed?(Raylib::MouseButton::Left) && Raylib.check_collision_point_rec?(mouse_position, vibrate_button)
    Raylib.set_gamepad_vibration(gamepad, 1.0, 1.0, 1.0)
  end

  Raylib.begin_drawing
  Raylib.clear_background(Raylib::RAYWHITE)

  if Raylib.gamepad_available?(gamepad)
    Raylib.draw_text("GP#{gamepad}: #{Raylib.get_gamepad_name(gamepad)}", 10, 10, 10, Raylib::BLACK)

    left_stick_x = Raylib.get_gamepad_axis_movement(gamepad, Raylib::GamepadAxis::LeftX)
    left_stick_y = Raylib.get_gamepad_axis_movement(gamepad, Raylib::GamepadAxis::LeftY)
    right_stick_x = Raylib.get_gamepad_axis_movement(gamepad, Raylib::GamepadAxis::RightX)
    right_stick_y = Raylib.get_gamepad_axis_movement(gamepad, Raylib::GamepadAxis::RightY)
    left_trigger = Raylib.get_gamepad_axis_movement(gamepad, Raylib::GamepadAxis::LeftTrigger)
    right_trigger = Raylib.get_gamepad_axis_movement(gamepad, Raylib::GamepadAxis::RightTrigger)

    left_stick_x = 0.0 if left_stick_x > -left_stick_deadzone_x && left_stick_x < left_stick_deadzone_x
    left_stick_y = 0.0 if left_stick_y > -left_stick_deadzone_y && left_stick_y < left_stick_deadzone_y
    right_stick_x = 0.0 if right_stick_x > -right_stick_deadzone_x && right_stick_x < right_stick_deadzone_x
    right_stick_y = 0.0 if right_stick_y > -right_stick_deadzone_y && right_stick_y < right_stick_deadzone_y
    left_trigger = -1.0 if left_trigger < left_trigger_deadzone
    right_trigger = -1.0 if right_trigger < right_trigger_deadzone

    name_lower = Raylib.text_to_lower(Raylib.get_gamepad_name(gamepad)).to_s

    if Raylib.text_find_index(name_lower, XBOX_ALIAS_1) > -1 || Raylib.text_find_index(name_lower, XBOX_ALIAS_2) > -1
      Raylib.draw_texture(tex_xbox_pad, 0, 0, Raylib::DARKGRAY)

      Raylib.draw_circle(394, 89, 19, Raylib::RED) if Raylib.gamepad_button_down?(gamepad, Raylib::GamepadButton::Middle)

      Raylib.draw_circle(436, 150, 9, Raylib::RED) if Raylib.gamepad_button_down?(gamepad, Raylib::GamepadButton::MiddleRight)
      Raylib.draw_circle(352, 150, 9, Raylib::RED) if Raylib.gamepad_button_down?(gamepad, Raylib::GamepadButton::MiddleLeft)
      Raylib.draw_circle(501, 151, 15, Raylib::BLUE) if Raylib.gamepad_button_down?(gamepad, Raylib::GamepadButton::RightFaceLeft)
      Raylib.draw_circle(536, 187, 15, Raylib::LIME) if Raylib.gamepad_button_down?(gamepad, Raylib::GamepadButton::RightFaceDown)
      Raylib.draw_circle(572, 151, 15, Raylib::MAROON) if Raylib.gamepad_button_down?(gamepad, Raylib::GamepadButton::RightFaceRight)
      Raylib.draw_circle(536, 115, 15, Raylib::GOLD) if Raylib.gamepad_button_down?(gamepad, Raylib::GamepadButton::RightFaceUp)

      Raylib.draw_rectangle(317, 202, 19, 26, Raylib::RED) if Raylib.gamepad_button_down?(gamepad, Raylib::GamepadButton::LeftFaceUp)
      Raylib.draw_rectangle(317, 247, 19, 26, Raylib::RED) if Raylib.gamepad_button_down?(gamepad, Raylib::GamepadButton::LeftFaceDown)
      Raylib.draw_rectangle(292, 228, 25, 19, Raylib::RED) if Raylib.gamepad_button_down?(gamepad, Raylib::GamepadButton::LeftFaceLeft)
      Raylib.draw_rectangle(336, 228, 26, 19, Raylib::RED) if Raylib.gamepad_button_down?(gamepad, Raylib::GamepadButton::LeftFaceRight)

      Raylib.draw_circle(259, 61, 20, Raylib::RED) if Raylib.gamepad_button_down?(gamepad, Raylib::GamepadButton::LeftTrigger1)
      Raylib.draw_circle(536, 61, 20, Raylib::RED) if Raylib.gamepad_button_down?(gamepad, Raylib::GamepadButton::RightTrigger1)

      left_gamepad_color = Raylib::BLACK
      left_gamepad_color = Raylib::RED if Raylib.gamepad_button_down?(gamepad, Raylib::GamepadButton::LeftThumb)
      Raylib.draw_circle(259, 152, 39, Raylib::BLACK)
      Raylib.draw_circle(259, 152, 34, Raylib::LIGHTGRAY)
      Raylib.draw_circle(259 + (left_stick_x * 20).to_i, 152 + (left_stick_y * 20).to_i, 25, left_gamepad_color)

      right_gamepad_color = Raylib::BLACK
      right_gamepad_color = Raylib::RED if Raylib.gamepad_button_down?(gamepad, Raylib::GamepadButton::RightThumb)
      Raylib.draw_circle(461, 237, 38, Raylib::BLACK)
      Raylib.draw_circle(461, 237, 33, Raylib::LIGHTGRAY)
      Raylib.draw_circle(461 + (right_stick_x * 20).to_i, 237 + (right_stick_y * 20).to_i, 25, right_gamepad_color)

      Raylib.draw_rectangle(170, 30, 15, 70, Raylib::GRAY)
      Raylib.draw_rectangle(604, 30, 15, 70, Raylib::GRAY)
      Raylib.draw_rectangle(170, 30, 15, (((1 + left_trigger) / 2) * 70).to_i, Raylib::RED)
      Raylib.draw_rectangle(604, 30, 15, (((1 + right_trigger) / 2) * 70).to_i, Raylib::RED)
    elsif Raylib.text_find_index(name_lower, PS_ALIAS_1) > -1 || Raylib.text_find_index(name_lower, PS_ALIAS_2) > -1
      Raylib.draw_texture(tex_ps3_pad, 0, 0, Raylib::DARKGRAY)

      Raylib.draw_circle(396, 222, 13, Raylib::RED) if Raylib.gamepad_button_down?(gamepad, Raylib::GamepadButton::Middle)

      Raylib.draw_rectangle(328, 170, 32, 13, Raylib::RED) if Raylib.gamepad_button_down?(gamepad, Raylib::GamepadButton::MiddleLeft)
      Raylib.draw_triangle(Raylib::Vector2.new(x: 436, y: 168), Raylib::Vector2.new(x: 436, y: 185), Raylib::Vector2.new(x: 464, y: 177), Raylib::RED) if Raylib.gamepad_button_down?(gamepad, Raylib::GamepadButton::MiddleRight)
      Raylib.draw_circle(557, 144, 13, Raylib::LIME) if Raylib.gamepad_button_down?(gamepad, Raylib::GamepadButton::RightFaceUp)
      Raylib.draw_circle(586, 173, 13, Raylib::RED) if Raylib.gamepad_button_down?(gamepad, Raylib::GamepadButton::RightFaceRight)
      Raylib.draw_circle(557, 203, 13, Raylib::VIOLET) if Raylib.gamepad_button_down?(gamepad, Raylib::GamepadButton::RightFaceDown)
      Raylib.draw_circle(527, 173, 13, Raylib::PINK) if Raylib.gamepad_button_down?(gamepad, Raylib::GamepadButton::RightFaceLeft)

      Raylib.draw_rectangle(225, 132, 24, 84, Raylib::BLACK)
      Raylib.draw_rectangle(195, 161, 84, 25, Raylib::BLACK)
      Raylib.draw_rectangle(225, 132, 24, 29, Raylib::RED) if Raylib.gamepad_button_down?(gamepad, Raylib::GamepadButton::LeftFaceUp)
      Raylib.draw_rectangle(225, 186, 24, 30, Raylib::RED) if Raylib.gamepad_button_down?(gamepad, Raylib::GamepadButton::LeftFaceDown)
      Raylib.draw_rectangle(195, 161, 30, 25, Raylib::RED) if Raylib.gamepad_button_down?(gamepad, Raylib::GamepadButton::LeftFaceLeft)
      Raylib.draw_rectangle(249, 161, 30, 25, Raylib::RED) if Raylib.gamepad_button_down?(gamepad, Raylib::GamepadButton::LeftFaceRight)

      Raylib.draw_circle(239, 82, 20, Raylib::RED) if Raylib.gamepad_button_down?(gamepad, Raylib::GamepadButton::LeftTrigger1)
      Raylib.draw_circle(557, 82, 20, Raylib::RED) if Raylib.gamepad_button_down?(gamepad, Raylib::GamepadButton::RightTrigger1)

      left_gamepad_color = Raylib::BLACK
      left_gamepad_color = Raylib::RED if Raylib.gamepad_button_down?(gamepad, Raylib::GamepadButton::LeftThumb)
      Raylib.draw_circle(319, 255, 35, Raylib::BLACK)
      Raylib.draw_circle(319, 255, 31, Raylib::LIGHTGRAY)
      Raylib.draw_circle(319 + (left_stick_x * 20).to_i, 255 + (left_stick_y * 20).to_i, 25, left_gamepad_color)

      right_gamepad_color = Raylib::BLACK
      right_gamepad_color = Raylib::RED if Raylib.gamepad_button_down?(gamepad, Raylib::GamepadButton::RightThumb)
      Raylib.draw_circle(475, 255, 35, Raylib::BLACK)
      Raylib.draw_circle(475, 255, 31, Raylib::LIGHTGRAY)
      Raylib.draw_circle(475 + (right_stick_x * 20).to_i, 255 + (right_stick_y * 20).to_i, 25, right_gamepad_color)

      Raylib.draw_rectangle(169, 48, 15, 70, Raylib::GRAY)
      Raylib.draw_rectangle(611, 48, 15, 70, Raylib::GRAY)
      Raylib.draw_rectangle(169, 48, 15, (((1 + left_trigger) / 2) * 70).to_i, Raylib::RED)
      Raylib.draw_rectangle(611, 48, 15, (((1 + right_trigger) / 2) * 70).to_i, Raylib::RED)
    else
      Raylib.draw_rectangle_rounded(Raylib::Rectangle.new(x: 175, y: 110, width: 460, height: 220), 0.3, 16, Raylib::DARKGRAY)

      Raylib.draw_circle(365, 170, 12, Raylib::RAYWHITE)
      Raylib.draw_circle(405, 170, 12, Raylib::RAYWHITE)
      Raylib.draw_circle(445, 170, 12, Raylib::RAYWHITE)
      Raylib.draw_circle(516, 191, 17, Raylib::RAYWHITE)
      Raylib.draw_circle(551, 227, 17, Raylib::RAYWHITE)
      Raylib.draw_circle(587, 191, 17, Raylib::RAYWHITE)
      Raylib.draw_circle(551, 155, 17, Raylib::RAYWHITE)
      Raylib.draw_circle(365, 170, 10, Raylib::RED) if Raylib.gamepad_button_down?(gamepad, Raylib::GamepadButton::MiddleLeft)
      Raylib.draw_circle(405, 170, 10, Raylib::GREEN) if Raylib.gamepad_button_down?(gamepad, Raylib::GamepadButton::Middle)
      Raylib.draw_circle(445, 170, 10, Raylib::BLUE) if Raylib.gamepad_button_down?(gamepad, Raylib::GamepadButton::MiddleRight)
      Raylib.draw_circle(516, 191, 15, Raylib::GOLD) if Raylib.gamepad_button_down?(gamepad, Raylib::GamepadButton::RightFaceLeft)
      Raylib.draw_circle(551, 227, 15, Raylib::BLUE) if Raylib.gamepad_button_down?(gamepad, Raylib::GamepadButton::RightFaceDown)
      Raylib.draw_circle(587, 191, 15, Raylib::GREEN) if Raylib.gamepad_button_down?(gamepad, Raylib::GamepadButton::RightFaceRight)
      Raylib.draw_circle(551, 155, 15, Raylib::RED) if Raylib.gamepad_button_down?(gamepad, Raylib::GamepadButton::RightFaceUp)

      Raylib.draw_rectangle(245, 145, 28, 88, Raylib::RAYWHITE)
      Raylib.draw_rectangle(215, 174, 88, 29, Raylib::RAYWHITE)
      Raylib.draw_rectangle(247, 147, 24, 84, Raylib::BLACK)
      Raylib.draw_rectangle(217, 176, 84, 25, Raylib::BLACK)
      Raylib.draw_rectangle(247, 147, 24, 29, Raylib::RED) if Raylib.gamepad_button_down?(gamepad, Raylib::GamepadButton::LeftFaceUp)
      Raylib.draw_rectangle(247, 201, 24, 30, Raylib::RED) if Raylib.gamepad_button_down?(gamepad, Raylib::GamepadButton::LeftFaceDown)
      Raylib.draw_rectangle(217, 176, 30, 25, Raylib::RED) if Raylib.gamepad_button_down?(gamepad, Raylib::GamepadButton::LeftFaceLeft)
      Raylib.draw_rectangle(271, 176, 30, 25, Raylib::RED) if Raylib.gamepad_button_down?(gamepad, Raylib::GamepadButton::LeftFaceRight)

      Raylib.draw_rectangle_rounded(Raylib::Rectangle.new(x: 215, y: 98, width: 100, height: 10), 0.5, 16, Raylib::DARKGRAY)
      Raylib.draw_rectangle_rounded(Raylib::Rectangle.new(x: 495, y: 98, width: 100, height: 10), 0.5, 16, Raylib::DARKGRAY)
      Raylib.draw_rectangle_rounded(Raylib::Rectangle.new(x: 215, y: 98, width: 100, height: 10), 0.5, 16, Raylib::RED) if Raylib.gamepad_button_down?(gamepad, Raylib::GamepadButton::LeftTrigger1)
      Raylib.draw_rectangle_rounded(Raylib::Rectangle.new(x: 495, y: 98, width: 100, height: 10), 0.5, 16, Raylib::RED) if Raylib.gamepad_button_down?(gamepad, Raylib::GamepadButton::RightTrigger1)

      left_gamepad_color = Raylib::BLACK
      left_gamepad_color = Raylib::RED if Raylib.gamepad_button_down?(gamepad, Raylib::GamepadButton::LeftThumb)
      Raylib.draw_circle(345, 260, 40, Raylib::BLACK)
      Raylib.draw_circle(345, 260, 35, Raylib::LIGHTGRAY)
      Raylib.draw_circle(345 + (left_stick_x * 20).to_i, 260 + (left_stick_y * 20).to_i, 25, left_gamepad_color)

      right_gamepad_color = Raylib::BLACK
      right_gamepad_color = Raylib::RED if Raylib.gamepad_button_down?(gamepad, Raylib::GamepadButton::RightThumb)
      Raylib.draw_circle(465, 260, 40, Raylib::BLACK)
      Raylib.draw_circle(465, 260, 35, Raylib::LIGHTGRAY)
      Raylib.draw_circle(465 + (right_stick_x * 20).to_i, 260 + (right_stick_y * 20).to_i, 25, right_gamepad_color)

      Raylib.draw_rectangle(151, 110, 15, 70, Raylib::GRAY)
      Raylib.draw_rectangle(644, 110, 15, 70, Raylib::GRAY)
      Raylib.draw_rectangle(151, 110, 15, (((1 + left_trigger) / 2) * 70).to_i, Raylib::RED)
      Raylib.draw_rectangle(644, 110, 15, (((1 + right_trigger) / 2) * 70).to_i, Raylib::RED)
    end

    Raylib.draw_text("DETECTED AXIS [#{Raylib.get_gamepad_axis_count(gamepad)}]:", 10, 50, 10, Raylib::MAROON)

    (0...Raylib.get_gamepad_axis_count(gamepad)).each do |i|
      Raylib.draw_text("AXIS %d: %.02f" % [i, Raylib.get_gamepad_axis_movement(gamepad, i)], 20, 70 + 20 * i, 10, Raylib::DARKGRAY)
    end

    Raylib.draw_rectangle_rec(vibrate_button, Raylib::SKYBLUE)
    Raylib.draw_text("VIBRATE", (vibrate_button.x + 14).to_i, (vibrate_button.y + 1).to_i, 10, Raylib::DARKGRAY)

    if Raylib.get_gamepad_button_pressed != 0
      Raylib.draw_text("DETECTED BUTTON: #{Raylib.get_gamepad_button_pressed}", 10, 430, 10, Raylib::RED)
    else
      Raylib.draw_text("DETECTED BUTTON: NONE", 10, 430, 10, Raylib::GRAY)
    end
  else
    Raylib.draw_text("GP#{gamepad}: NOT DETECTED", 10, 10, 10, Raylib::GRAY)
    Raylib.draw_texture(tex_xbox_pad, 0, 0, Raylib::LIGHTGRAY)
  end

  Raylib.end_drawing
end

Raylib.unload_texture(tex_ps3_pad)
Raylib.unload_texture(tex_xbox_pad)
Raylib.close_window
