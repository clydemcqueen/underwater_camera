include <mc_common.scad>

// Future: move to library
module wedge_2d(r, a) {
  intersection() {
    circle(r = r);
    square(r);
    rotate(a - 90)
      square(r);
  }
}

// Create a hole for a screw and nut
// Screw hole and nut hole meet at [0, 0, 0] and run along the z axis
// Future: move to library
module nut_hole(length = 10) {
  linear_extrude(length)
    circle(clamp_nut_r, $fn = 6);

  translate([0, 0, - length])
    linear_extrude(length + 0.1)
      circle(clamp_screw_r);
}

module clamp_2d() {

  difference() {
    circle(r = clamp_ext_r);
    circle(r = clamp_int_r);
    wedge_2d(r = clamp_ext_r, a = clamp_cut_a);
  }

  // Overlap w/ the ring itself
  total_tab = [clamp_tab.x + clamp_thickness, clamp_tab.y];

  // Bottom tab (for nut)
  translate([clamp_int_r, - clamp_tab.y])
    square(total_tab);

  // Top tab (for screw)
  translate([tube_r_outside * cos(clamp_cut_a), tube_r_outside * sin(clamp_cut_a)])
    rotate(clamp_cut_a)
      square(total_tab);
}

module clamp() {
  difference() {
    linear_extrude(clamp_height, center = true, convexity = 5)
      clamp_2d();

    screw_x = tube_r_outside + clamp_thickness + clamp_tab.x / 2 - 1;

    // Nut
    translate([screw_x, - 4, 0])
      rotate([90, 0, 0])
        nut_hole(clamp_tab.y / 2 + 1);

    // Screw
    translate([screw_x * cos(clamp_cut_a), screw_x * sin(clamp_cut_a) + clamp_tab.y / 2, 0])
      rotate([90, 0, clamp_cut_a])
        cylinder(r = clamp_screw_r, h = clamp_tab.y + 1, center = true);
  }
}

module base() {
  linear_extrude(clamp_height, center = true)
    base_2d();

  // Add ridges to hold mount part
  // Be sure to subtract slot_tolerance
  for (ridge_x = [- ridge_offset, ridge_offset]) {
    translate([ridge_x, 0, clamp_height / 2 + ridge_height / 2])
      cube([ridge_width - slot_tolerance, base_size.y, ridge_height], center = true);
  }
}

module mono_clamp() {
  translate([camera_center, 0, 0])
    clamp();

  base();
}
