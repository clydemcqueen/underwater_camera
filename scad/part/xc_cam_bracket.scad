include <xc_common.scad>

include <../include/clip_circle.scad>
include <../include/standoffs.scad>

include <NopSCADlib/core.scad>

battery_r_tolerance = 0.1;

module cam_bracket_ring_2d() {
  difference() {
    circle(r = bracket_r);
    difference() {
      circle(r = interior_r);
      cam_box_2d();
    }

    // Holes
    for (int_hole = pen_flange_int_holes) {
      translate([int_hole.x, int_hole.y])
        circle(r = 1.5);
    }
  }
}

module cam_bracket_ring() {
  linear_extrude(height = bracket_ring_h, convexity = 5)
    cam_bracket_ring_2d();
}

module cam_box_2d() {
  clip_circle(interior_r, - 12.675, 4);
}

// Cam "box" sits inside the flange and supports the camera
module cam_box(lens_adapter) {
  box_h = 8.8;
  standoff_h = 2.7;
  standoff_wall = 1.3;

  // Bottom part
  linear_extrude(height = box_h)
    cam_box_2d();

  // Is there a lens adapter, e.g., for the wide angle lens?
  //
  // If yes, use just 2 screw holes. Note that standoff_h should allow the cable connector to
  // touch the box, so the camera should sit squarely.
  //
  // If no, use all 4 screw holes.
  holes = lens_adapter ? [cam_holes[0], cam_holes[1]] : cam_holes;

  // Standoffs
  translate([cam_center_point.x, cam_center_point.y, box_h])
    standoffs(holes, standoff_h, standoff_wall, cam_hole_r);
}

// Bracket for the camera flange
module cam_bracket(lens_adapter) {
  // Ring attaches to flange and has slots for the trays
  cam_bracket_ring();

  // Camera box sits _underneath_ the ring
  translate([0, 0, bracket_ring_h])
    cam_box(lens_adapter);
}
