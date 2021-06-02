// External camera: full assembly

include <flags.scad>
include <ec_cam_side.scad>
include <ec_pen_side.scad>

include <../part/ec_common.scad>
include <../vitamin/adafruit.scad>
include <../vitamin/blue_robotics.scad>
include <../vitamin/pi_camera.scad>
include <../vitamin/pi_zero.scad>

module external_camera_assembly() {
  cam_assembly();
  pen_assembly();

  if (render_tube)
    color("gray", 0.4)
      translate(tube_placement)
        rotate(tube_rotation)
          two_inch_tube();
}

$fn = 60;
external_camera_assembly();
