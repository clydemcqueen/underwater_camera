include <wc_common.scad>
include <../vitamin/pi_zero.scad>

pi_hole_y_adj = 1.1;

module hole_for_struct_bracket1() {
  for (x = [support_h / 2]) {
    translate([x, 0, 0])
      rotate([0, 90, 0])
        cylinder(r = 0.9, h = 14, center = true);
  }
}

// Build a support for the pi or the proto board
module support(angle, knockout = false) {
  y_offset = support_y_offset(angle);
  dir = support_dir(angle);
  // echo(angle, y_offset, dir, knockout);

  difference() {
    translate([0, y_offset, 0])
      cube(support_size, center = true);

    // Pi
    rotate([- angle, 0, 0]) {
      translate([0, 0, - 12.4])
        cube([support_h + 0.1, 20, 20], center = true);

      for (hole_x = [- pi_hole_x, pi_hole_x]) {
        translate([bracket_ring_h - pi_adj + hole_x, dir * pi_hole_y_adj, - 5])
          cylinder(r = M2_hole_side_print_r, h = 10);
      }

      // Knockout for pi header, as well as wires soldered to pads on the back of the pi
      if (knockout)
        translate([bracket_ring_h - pi_adj, dir, - 6])
          cube([pi_header_size.x, 12, 10], center = true);
    }

    hole_for_struct_bracket1();
  }
}

module support1() {
  support(support1_angle, knockout = true);
}

module support2() {
  support(support2_angle, knockout = true);
}

module support3() {
  support(support3_angle);
}

module support4() {
  support(support4_angle);
}
