// Battery-powered camera: full assembly

include <flags.scad>
include <xc_cam_side.scad>
include <ec_interior.scad>

include <../part/ec_common.scad>
include <../vitamin/adafruit.scad>
include <../vitamin/blue_robotics.scad>
include <../vitamin/pi_camera.scad>
include <../vitamin/pi_zero.scad>

module external_camera_assembly() {
  cam_assembly();
  interior_assembly();

  if (render_flanges)
    color("#5252b4", 0.5)
      translate(pen_flange_placement)
        rotate(pen_flange_rotation)
          pen_flange();

  if (render_tube)
    color("gray", 0.4)
      translate(tube_placement)
        rotate(tube_rotation)
          two_inch_tube();
}

$fn = 60;
external_camera_assembly();
