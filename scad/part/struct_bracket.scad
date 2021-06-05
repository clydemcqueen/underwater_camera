include <ec_common.scad>

include <supports.scad>

include <../include/clip_circle.scad>
include <../include/pie_slice.scad>
include <../vitamin/adafruit.scad>
include <../vitamin/blue_robotics.scad>
include <../vitamin/pi_zero.scad>

battery_well_inside_r = battery_r + 0.1;
battery_well_outside_r = battery_well_inside_r + 1;

module struct_bracket1_ring_2d() {
  difference() {
    circle(r = bracket_r);
    circle(r = interior_r);

    // Holes
    for (int_hole = pen_flange_int_holes) {
      translate([int_hole.x, int_hole.y])
        circle(r = 1.5);
    }
  }

  // Support for battery well
  rotate(180)
    translate([battery_placement.x, - battery_placement.y])
      rotate(90)
        clip_circle(battery_well_outside_r, battery_well_clip, - battery_well_clip);
}

module struct_bracket2_ring_2d() {
  difference() {
    circle(r = bracket_r);
    circle(r = interior_r);
  }

  // Support for battery well
  translate([battery_placement.x, - battery_placement.y])
    rotate(90)
      clip_circle(battery_well_outside_r, battery_well_clip, - battery_well_clip);

  // Support for pb board
  rotate(- pb_angle)
    translate([0, 0])
      clip_circle(bracket_r, 0, - 35);
}

module struct_bracket1_ring() {
  difference() {
    linear_extrude(height = bracket_ring_h, convexity = 5)
      struct_bracket1_ring_2d();

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

module struct_bracket2_ring() {
  difference() {
    linear_extrude(height = bracket_ring_h, convexity = 5)
      struct_bracket2_ring_2d();

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
          translate([- 5, pb_hole.y, 0])
            rotate([0, 90, 0])
              cylinder(r = 0.9, h = 12);
        }
      }
    }
  }
}

module battery_well() {
  translate([battery_placement.x, - battery_placement.y, bracket_ring_h]) {
    linear_extrude(height = 20, convexity = 5) {
      donutSlice(battery_well_outside_r, battery_well_inside_r, - battery_well_angle, battery_well_angle);
      donutSlice(battery_well_outside_r, battery_well_inside_r, 180 - battery_well_angle, 180 + battery_well_angle);
    }
  }
}

module struct_bracket1() {
  struct_bracket1_ring();
  rotate([0, 0, 180])
    battery_well();
}

module struct_bracket2() {
  struct_bracket2_ring();
  battery_well();

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
    }
}
