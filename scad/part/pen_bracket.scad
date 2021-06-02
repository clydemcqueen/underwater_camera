include <ec_common.scad>

include <../include/pie_slice.scad>
include <../vitamin/adafruit.scad>
include <../vitamin/pi_zero.scad>

// Experiment -- long extrusions
module supports_2d() {
  support_half_angle = 10;
  donutSlice(bracket_r, interior_r, third_support_angle - support_half_angle, third_support_angle + support_half_angle);

  difference() {
    // Two long supports hold the pi. Each is 22 degrees wide. Centered on -31 and 31.
    union() {
      donutSlice(bracket_r, interior_r, - 42, - 20);
      donutSlice(bracket_r, interior_r, 20, 42);
    }

    // Knock out pi
    translate([12.2, 0])
      square([10, 40], center = true);
  }
}

module supports() {
  translate([0, 0, bracket_ring_h]) {
    difference() {
      linear_extrude(height = support_h, convexity = 5) {
        supports_2d();
      }
      // Knock out room for the back of the header
      translate([14.2, 11.5, support_h / 2])
        cube([10, pi_header_size.y, pi_header_size.x], center = true);

      // Holes to attach pi to supports
      for (pi_hole = pi_holes) {
        translate([15, pi_hole.y, pi_hole.x + support_h / 2])
          rotate([0, 90, 0])
            cylinder(r = M2_hole_side_print_r, h = 10);
      }

      // Holes to attach to cam bracket
      for (connect_hole = connect_holes) {
        translate([connect_hole.x, connect_hole.y, support_h - 8])
          cylinder(r = M2_hole_r, h = 10);
      }
    }
  }
}

module pen_bracket_ring_2d() {
  difference() {
    circle(r = bracket_r);

    // Knockout for the switch and wires
    translate([- 9, 1])
      circle(r = 7);
  }
}

module pen_bracket_ring() {
  difference() {
    linear_extrude(height = bracket_ring_h, convexity = 5)
      pen_bracket_ring_2d();

    rotate([0, 0, 180 - pb_angle]) {
      translate([13.7, 0, bracket_ring_h / 2]) {

        // Knockout for the pb pcb
        translate([10.225, 0, 0])
          cube([11.9, 25.2, 10], center = true);

        // Knockout for the pb components
        translate([2.825, 0, 0])
          cube([3, 10, 10], center = true);

        // Holes for the pb
        for (pb_hole = pb_holes) {
          translate([- 4, pb_hole.y, 0])
            rotate([0, 90, 0])
              cylinder(r = M2_hole_side_print_r, h = 10);
        }
      }
    }
  }
}

module battery_well() {
  translate([battery_placement.x, - battery_placement.y, bracket_ring_h])
    linear_extrude(height = 20) {
      donutSlice((battery_d + 2.5) / 2, (battery_d + 0.5) / 2, - 60, 60);
      donutSlice((battery_d + 2.5) / 2, (battery_d + 0.5) / 2, 120, 240);
    }
}

// Bracket for the penetration flange
module pen_bracket() {
  pen_bracket_ring();
  supports();
  battery_well();
}
