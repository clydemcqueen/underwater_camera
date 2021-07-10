// Wired camera: full assembly

include <flags.scad>
include <xc_cam_side.scad>
include <wc_interior.scad>

include <../part/wc_common.scad>

module wired_camera_assembly() {
  cam_assembly();
  wired_interior_assembly();

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
wired_camera_assembly();
