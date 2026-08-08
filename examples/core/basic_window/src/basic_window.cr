#
#   Copyright (c) 2013-2026 Ramon Santamaria (@raysan5)
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

Raylib.init_window(SCREENWIDTH, SCREENHEIGHT, "Raylib [core] example - basic window")

Raylib.set_target_fps(60) # Set our game to run at 60 frames-per-second
# --------------------------------------------------------------------------------------

# Main game loop
until Raylib.close_window? # Detect window close button or ESC key
  # Update
  # ----------------------------------------------------------------------------------
  # TODO: Update your variables here
  # ----------------------------------------------------------------------------------

  # Draw
  # ----------------------------------------------------------------------------------
  Raylib.begin_drawing

  Raylib.clear_background(Raylib::RAYWHITE)

  Raylib.draw_text("Congrats! You created your first window!", 190, 200, 20, Raylib::LIGHTGRAY)

  Raylib.end_drawing
  # ----------------------------------------------------------------------------------
end

# De-Initialization
# --------------------------------------------------------------------------------------
Raylib.close_window # Close window and OpenGL context
# --------------------------------------------------------------------------------------
