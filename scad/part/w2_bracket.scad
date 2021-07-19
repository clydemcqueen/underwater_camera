// Wired camera v2 interior parts

include <w2_common.scad>

module w2_bracket_ring_2d() {
  difference() {
    circle(r = bracket_r);
    circle(r = interior_r);

    // Holes
    for (int_hole = pen_flange_int_holes) {
      translate([int_hole.x, int_hole.y])
        circle(r = 1.5);
    }
  }
}

module w2_bracket_ring() {
  difference() {
    linear_extrude(height = bracket_ring_h, convexity = 5)
      w2_bracket_ring_2d();
  }
}

standoff_r = 2.8;
standoff_screw_r = 1.5;
standoff_h = 14.5;
support_skew = 4.2;

module support(skew) {
  difference() {
    hull() {
      rotate([0, 90, 0])
        cylinder(r = standoff_r, h = w2_standoff, center = true);
      translate([0, skew, - standoff_h])
        cube([w2_standoff, standoff_r * 2, bracket_ring_h], center = true);
    }
    rotate([0, 90, 0])
      cylinder(r = standoff_screw_r, h = w2_standoff + 0.1, center = true);
  }
}

module w2_bracket() {
  w2_bracket_ring();

  support1_placement = [pi_placement.x - pi_z - w2_standoff / 2, pi_hole_y, bracket_ring_h / 2 + standoff_h];
  support2_placement = [support1_placement.x, - support1_placement.y, support1_placement.z];

  translate(support1_placement)
    support(support_skew);

  translate(support2_placement)
    support(- support_skew);
}
