include <common.scad>

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
module cam_box() {
  box_h = 8.8;
  standoff_h = 2.7;
  standoff_wall = 1.3;

  // Bottom part
  linear_extrude(height = box_h)
    cam_box_2d();

  // Standoffs
  two_holes = [cam_holes[0], cam_holes[1]];
  translate([cam_center_point.x, cam_center_point.y, box_h])
    standoffs(two_holes, standoff_h, standoff_wall, cam_hole_r);
}

// Bracket for the camera flange
module cam_bracket() {
  // Ring attaches to flange and has slots for the trays
  cam_bracket_ring();

  // Camera box sits _underneath_ the ring
  translate([0, 0, bracket_ring_h])
    cam_box();
}
