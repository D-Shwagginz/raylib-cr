#
#   Copyright (c) 2014-2025 Ramon Santamaria (@raysan5)
#   Copyright (c) 2026 Devin Shwagginz (@D-Shwagginz)
#

require "raylib-cr"

#------------------------------------------------------------------------------------
# Program main entry point
#------------------------------------------------------------------------------------
    # Initialization
    #--------------------------------------------------------------------------------------
    SCREENWIDTH = 800
    SCREENHEIGHT = 450

    Raylib.init_window(SCREENWIDTH, SCREENHEIGHT, "raylib [core] example - input mouse wheel")

    box_position_y = SCREENHEIGHT/2 - 40
    scroll_speed = 4            # Scrolling speed in pixels

    Raylib.set_target_fps(60)               # Set our game to run at 60 frames-per-second
    #--------------------------------------------------------------------------------------

    # Main game loop
    until Raylib.close_window?    # Detect window close button or ESC key
        # Update
        #----------------------------------------------------------------------------------
        box_position_y -= (Raylib.get_mouse_wheel_move()*scroll_speed).to_i
        #----------------------------------------------------------------------------------

        # Draw
        #----------------------------------------------------------------------------------
        Raylib.begin_drawing()

            Raylib.clear_background(Raylib::RAYWHITE)

            Raylib.draw_rectangle(SCREENWIDTH/2 - 40, box_position_y, 80, 80, Raylib::MAROON)

            Raylib.draw_text("Use mouse wheel to move the cube up and down!", 10, 10, 20, Raylib::GRAY)
            Raylib.draw_text("Box position Y: #{box_position_y}", 10, 40, 20, Raylib::LIGHTGRAY)

        Raylib.end_drawing()
        #----------------------------------------------------------------------------------
    end

    # De-Initialization
    #--------------------------------------------------------------------------------------
    Raylib.close_window()        # Close window and OpenGL context
    #--------------------------------------------------------------------------------------