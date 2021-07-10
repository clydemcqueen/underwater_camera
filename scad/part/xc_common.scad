// Common between ec_ (battery-powered camera) and wc_ (wired camera)

include <../vitamin/blue_robotics.scad>
include <../vitamin/pi_camera.scad>

// All tolerances measured for my Prusa MK3S + PLA + 0.15mm layers

// Good M2 hole radius
M2_hole_r = 1.1;

// When printed sideways it needs to be a bit smaller
M2_hole_side_print_r = 1;

// M2 head radius, for insets
M2_head_r = 1.85;

// Build a structure with 2 circular ("ring") brackets connected by long supports
// Overall structure size:
structure_h = 87;
bracket_ring_h = 4;
support_h = structure_h - 3 * bracket_ring_h;

// Bracket radius, slightly smaller than the inside of the tube
bracket_r = tube_r_inside - 0.2;

// Interior radius, slightly smaller than the inside of the flange
interior_r = flange_int_r - 0.2;

// Cam flange can be in any orientation. Rotate so that the flange holes miss the support holes.
cam_flange_a = 0;
pen_flange_int_holes = [for (a = [cam_flange_a, cam_flange_a + 90, cam_flange_a + 180, cam_flange_a + 270])
  [cos(a) * flange_int_hole_offset, sin(a) * flange_int_hole_offset]];

// Build the stack from the camera flange upwards to the penetration flange
cam_flange_placement = [0, 0, 0];
cam_flange_rotation = [0, 0, 0];

// Camera bracket is built upside down, so rotate into place
cam_bracket_placement = [0, 0, flange_h + bracket_ring_h];
cam_bracket_rotation = [180, 0, 0];

// Place penetration flange
pen_flange_placement = [0, 0, 132];
pen_flange_rotation = [0, 180, 0];

// Place 2" tube
tube_placement = [0, 0, flange_ext_h];
tube_rotation = [0, 0, 0];
