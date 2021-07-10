include <ec_common.scad>

pi_hole_y_adj = 1.1;

module hole_for_struct_bracket1() {
  for (x = [support_h / 2]) {
    translate([x, 0, 0])
      rotate([0, 90, 0])
        cylinder(r = 0.9, h = 14, center = true);
  }
}

module support1() {
  difference() {
    translate([0, support1_y_offset, 0])
      cube(support1_size, center = true);

    // Pi
    rotate([- support1_angle, 0, 0]) {
      translate([0, 0, - 12.4])
        cube([support_h + 0.1, 20, 20], center = true);

      translate([bracket_ring_h - pi_adj + pi_hole_x, pi_hole_y_adj, - 5])
        cylinder(r = M2_hole_side_print_r, h = 10);
    }

    hole_for_struct_bracket1();
  }
}

module support2() {
  difference() {
    translate([0, support2_y_offset, 0])
      cube(support2_size, center = true);

    // Pi
    rotate([- support2_angle, 0, 0]) {
      translate([0, 0, - 12.4])
        cube([support_h + 0.1, 20, 20], center = true);

      for (hole_x = [- pi_hole_x, pi_hole_x]) {
        translate([bracket_ring_h - pi_adj + hole_x, - pi_hole_y_adj, - 5])
          cylinder(r = M2_hole_side_print_r, h = 10);
      }

      // Header
      translate([bracket_ring_h - pi_adj, - 1.2, - 6])
        cube([pi_header_size.x, pi_header_size.y, 10], center = true);
    }

    hole_for_struct_bracket1();
  }
}

module support3() {
  difference() {
    cube(support3_size, center = true);

    // Hole for struct_bracket1
    for (x = [support_h / 2]) {
      translate([x, 0, 0])
        rotate([0, 90, 0])
          cylinder(r = 0.9, h = 14, center = true);
    }
  }
}