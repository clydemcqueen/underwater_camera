// Wired camera v2: full assembly

include <flags.scad>
include <xc_cam_side.scad>
include <w2_interior.scad>

include <../part/w2_common.scad>

module w2_assembly() {
  cam_assembly(lens_adapter = false);
  w2_interior_assembly();

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
w2_assembly();
