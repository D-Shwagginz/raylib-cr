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

Raylib.init_window(SCREENWIDTH, SCREENHEIGHT, "raylib [core] example - input mouse")

ball_position = Raylib::Vector2.new(x: -100.0, y: -100.0)
ball_color = Raylib::DARKBLUE

Raylib.set_target_fps(60) # Set our game to run at 60 frames-per-second
# ---------------------------------------------------------------------------------------

# Main game loop
until Raylib.close_window? # Detect window close button or ESC key
  # Update
  # ----------------------------------------------------------------------------------
  if (Raylib.key_pressed?(Raylib::KeyboardKey::H))
    if (Raylib.cursor_hidden?)
      Raylib.show_cursor
    else
      Raylib.hide_cursor
    end
  end

  ball_position = Raylib.get_mouse_position

  if (Raylib.mouse_button_pressed?(Raylib::MouseButton::Left))
    ball_color = Raylib::MAROON
  elsif (Raylib.mouse_button_pressed?(Raylib::MouseButton::Middle))
    ball_color = Raylib::LIME
  elsif (Raylib.mouse_button_pressed?(Raylib::MouseButton::Right))
    ball_color = Raylib::DARKBLUE
  elsif (Raylib.mouse_button_pressed?(Raylib::MouseButton::Side))
    ball_color = Raylib::PURPLE
  elsif (Raylib.mouse_button_pressed?(Raylib::MouseButton::Extra))
    ball_color = Raylib::YELLOW
  elsif (Raylib.mouse_button_pressed?(Raylib::MouseButton::Forward))
    ball_color = Raylib::ORANGE
  elsif (Raylib.mouse_button_pressed?(Raylib::MouseButton::Back))
    ball_color = Raylib::BEIGE
  end
  # ----------------------------------------------------------------------------------

  # Draw
  # ----------------------------------------------------------------------------------
  Raylib.begin_drawing

  Raylib.clear_background(Raylib::RAYWHITE)

  Raylib.draw_circle_v(ball_position, 40, ball_color)

  Raylib.draw_text("move ball with mouse and click mouse button to change color", 10, 10, 20, Raylib::DARKGRAY)
  Raylib.draw_text("Press 'H' to toggle cursor visibility", 10, 30, 20, Raylib::DARKGRAY)

  if (Raylib.cursor_hidden?)
    Raylib.draw_text("CURSOR HIDDEN", 20, 60, 20, Raylib::RED)
  else
    Raylib.draw_text("CURSOR VISIBLE", 20, 60, 20, Raylib::LIME)
  end
  Raylib.end_drawing
  # ----------------------------------------------------------------------------------
end

# De-Initialization
# --------------------------------------------------------------------------------------
Raylib.close_window # Close window and OpenGL context
# --------------------------------------------------------------------------------------
