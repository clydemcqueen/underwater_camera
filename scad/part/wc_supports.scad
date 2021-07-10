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

// TODO beef up supports so they don't warp; pi and proto move toward the center
// TODO provide space for usb wires

module support(angle, y_offset, hole_y, header_kn = false) {
  difference() {
    translate([0, y_offset, 0])
      cube(support_size, center = true);

    // Pi
    rotate([- angle, 0, 0]) {
      translate([0, 0, - 12.4])
        cube([support_h + 0.1, 20, 20], center = true);

      for (hole_x = [- pi_hole_x, pi_hole_x]) {
        translate([bracket_ring_h - pi_adj + hole_x, hole_y, - 5])
          cylinder(r = M2_hole_side_print_r, h = 10);
      }

      // Header
      if (header_kn)
        translate([bracket_ring_h - pi_adj, - 1.2, - 6])
          cube([pi_header_size.x, pi_header_size.y, 10], center = true);

    }



    hole_for_struct_bracket1();
  }
}

module support1() {
  support(support1_angle, support1_y_offset, pi_hole_y_adj);
//  }
}

module support2() {
  support(support2_angle, support2_y_offset, - pi_hole_y_adj, header_kn = true);
}

module support3() {
  support(support3_angle, support3_y_offset, pi_hole_y_adj);
}

module support4() {
  support(support4_angle, support4_y_offset, - pi_hole_y_adj);
}
