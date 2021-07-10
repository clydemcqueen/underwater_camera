// Wired camera interior parts

include <wc_common.scad>

include <wc_supports.scad>

module wc_bracket1_ring_2d() {
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

module wc_bracket2_ring_2d() {
  difference() {
    circle(r = bracket_r);
    circle(r = interior_r);
  }
}

module wc_bracket1_ring() {
  difference() {
    linear_extrude(height = bracket_ring_h, convexity = 5)
      wc_bracket1_ring_2d();

    for (connect_hole = connect_holes) {
      // Holes to attach to cam bracket
      translate([connect_hole.x, - connect_hole.y, - 3])
        cylinder(r = M2_hole_r, h = 10);

      // Insets for M2 nuts
      translate([connect_hole.x, - connect_hole.y, - 8])
        cylinder(r = M2_head_r, h = 10);
    }
  }
}

module wc_bracket2_ring() {
  difference() {
    linear_extrude(height = bracket_ring_h, convexity = 5)
      wc_bracket2_ring_2d();
  }
}

module wc_bracket1() {
  wc_bracket1_ring();
}

module wc_bracket2() {
  wc_bracket2_ring();

  translate([0, 0, flange_h + support_h + bracket_ring_h * 3])
    rotate([180, 0, 0]) {
      translate(support1_placement)
        rotate(support1_rotation)
          support1();

      translate(support2_placement)
        rotate(support2_rotation)
          support2();

      translate(support3_placement)
        rotate(support3_rotation)
          support3();

      translate(support4_placement)
        rotate(support4_rotation)
          support4();
    }
}
