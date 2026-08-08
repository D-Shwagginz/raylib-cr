#
#   Copyright (c) 2014-2025 Ramon Santamaria (@raysan5)
#   Copyright (c) 2026 Devin Shwagginz (@D-Shwagginz)
#

require "raylib-cr"

# ------------------------------------------------------------------------------------
# Program main entry point
# ------------------------------------------------------------------------------------

# Initialization
# --------------------------------------------------------------------------------------
SCREENWIDTH  = 800
SCREENHEIGHT = 450

Raylib.init_window(SCREENWIDTH, SCREENHEIGHT, "raylib [core] example - input keys")

ball_position = Raylib::Vector2.new(x: SCREENWIDTH/2.0, y: SCREENHEIGHT/2.0)

Raylib.set_target_fps(60) # Set our game to run at 60 frames-per-second
# --------------------------------------------------------------------------------------

# Main game loop
until Raylib.close_window? # Detect window close button or ESC key
  # Update
  # ----------------------------------------------------------------------------------
  ball_position.x += 2.0 if (Raylib.key_down?(Raylib::KeyboardKey::Right))
  ball_position.x -= 2.0 if (Raylib.key_down?(Raylib::KeyboardKey::Left))
  ball_position.y -= 2.0 if (Raylib.key_down?(Raylib::KeyboardKey::Up))
  ball_position.y += 2.0 if (Raylib.key_down?(Raylib::KeyboardKey::Down))
  # ----------------------------------------------------------------------------------

  # Draw
  # ----------------------------------------------------------------------------------
  Raylib.begin_drawing

  Raylib.clear_background(Raylib::RAYWHITE)

  Raylib.draw_text("move the ball with arrow keys", 10, 10, 20, Raylib::DARKGRAY)

  Raylib.draw_circle_v(ball_position, 50, Raylib::MAROON)

  Raylib.end_drawing
  # ----------------------------------------------------------------------------------
end

# De-Initialization
# --------------------------------------------------------------------------------------
Raylib.close_window # Close window and OpenGL context
# --------------------------------------------------------------------------------------
