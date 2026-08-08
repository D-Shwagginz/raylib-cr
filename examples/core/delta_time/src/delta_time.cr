#
#  Copyright (c) 2025 Robin (@RobinsAviary)
#  Copyright (c) 2026 Devin Shwagginz (@D-Shwagginz)
#

require "raylib-cr"

# ------------------------------------------------------------------------------------
# Program main entry point
# ------------------------------------------------------------------------------------
# Initialization
# --------------------------------------------------------------------------------------
SCREENWIDTH  = 800
SCREENHEIGHT = 450

Raylib.init_window(SCREENWIDTH, SCREENHEIGHT, "raylib [core] example - delta time")

current_fps = 60

# Store the position for the both of the circles
delta_circle = Raylib::Vector2.new(x: 0, y: SCREENHEIGHT/3.0)
frame_circle = Raylib::Vector2.new(x: 0, y: SCREENHEIGHT*(2.0/3.0))

# The speed applied to both circles
speed = 10.0
circle_radius = 32.0

Raylib.set_target_fps(current_fps)
# --------------------------------------------------------------------------------------

# Main game loop
until Raylib.close_window? # Detect window close button or ESC key
  # Update
  # ----------------------------------------------------------------------------------
  # Adjust the FPS target based on the mouse wheel
  mouse_wheel = Raylib.get_mouse_wheel_move
  if mouse_wheel != 0
    current_fps += mouse_wheel.to_i32
    current_fps = 0 if (current_fps < 0)
    Raylib.set_target_fps(current_fps)
  end

  # GetFrameTime() returns the time it took to draw the last frame, in seconds (usually called delta time)
  # Uses the delta time to make the circle look like it's moving at a "consistent" speed regardless of FPS

  # Multiply by 6.0 (an arbitrary value) in order to make the speed
  # visually closer to the other circle (at 60 fps), for comparison
  delta_circle.x += Raylib.get_frame_time*6.0*speed
  # This circle can move faster or slower visually depending on the FPS
  frame_circle.x += 0.1*speed

  # If either circle is off the screen, reset it back to the start
  delta_circle.x = 0 if (delta_circle.x > SCREENWIDTH)
  frame_circle.x = 0 if (frame_circle.x > SCREENWIDTH)

  # Reset both circles positions
  if Raylib.key_pressed?(Raylib::KeyboardKey::R)
    delta_circle.x = 0
    frame_circle.x = 0
  end
  # ----------------------------------------------------------------------------------

  # Draw
  # ----------------------------------------------------------------------------------
  Raylib.begin_drawing
  Raylib.clear_background(Raylib::RAYWHITE)

  # Draw both circles to the screen
  Raylib.draw_circle_v(delta_circle, circle_radius, Raylib::RED)
  Raylib.draw_circle_v(frame_circle, circle_radius, Raylib::BLUE)

  # Draw the help text
  # Determine what help text to show depending on the current FPS target
  fps_text = 0
  if (current_fps <= 0)
    fps_text = "FPS: unlimited (#{Raylib.get_fps})"
  else
    fps_text = "FPS: #{Raylib.get_fps} (target: #{current_fps})"
  end
  Raylib.draw_text(fps_text, 10, 10, 20, Raylib::DARKGRAY)
  Raylib.draw_text("Frame time: #{Raylib.get_frame_time} ms", 10, 30, 20, Raylib::DARKGRAY)
  Raylib.draw_text("Use the scroll wheel to change the fps limit, r to reset", 10, 50, 20, Raylib::DARKGRAY)

  # Draw the text above the circles
  Raylib.draw_text("FUNC: x += Raylib.get_frame_time()*speed", 10, 90, 20, Raylib::RED)
  Raylib.draw_text("FUNC: x += speed", 10, 240, 20, Raylib::BLUE)

  Raylib.end_drawing
  # ---------------------------------------------------------------------------------
end

# De-Initialization
# --------------------------------------------------------------------------------------
Raylib.close_window # Close window and OpenGL context
# --------------------------------------------------------------------------------------
