include <ec_common.scad>
include <../include/clip_circle.scad>
include <../include/standoffs.scad>
include <../vitamin/adafruit.scad>
include <../vitamin/pi_camera.scad>
include <NopSCADlib/core.scad>

battery_r_tolerance = 0.1;

module cam_bracket_ring_2d() {
  difference() {
    circle(r = bracket_r);

    // Holes
    for (int_hole = flange_int_holes_flipped) {
      translate([int_hole.x, int_hole.y])
        circle(r = 1.5);
    }

    // Slot for the pi tray
    translate(pi_cam_slot_pos)
      square(pi_cam_slot, center = true);

    // Slot for the pb tray
    translate(pb_cam_slot_pos)
      square(pb_cam_slot, center = true);

    // Knockout for the camera ribbon cable
    translate([pi_center_offset - 5, 0])
      square([4, 24], center = true);

    // Knockout for battery
    translate([battery_pos.x, battery_pos.y])
      circle(r = battery_r + battery_r_tolerance);
  }
}

module cam_box_2d() {
  x1 = pb_center_offset - (pb_tray_size.z + tab_slot_tolerance) / 2 - interior_r;
  x2 = 4;
  clip_circle(interior_r, x1, x2);
}

// Create a hole for a screw and nut, uses data from NopSCADlib
// Screw hole and nut hole meet at [0, 0, 0] and run along the z axis
module nut_hole(type, length = 10) {
  screw_rad = M2_hole_r;
  nut_rad = nut_radius(type); // Radius of nut

  linear_extrude(length)
    circle(nut_rad, $fn = 6);

  translate([0, 0, - length])
    linear_extrude(length + 0.1)
      circle(screw_rad);
}

// A complicated little box: standoffs for the pi camera, room for the battery, holes to
// attach the pb tray, and it must fit inside the narrow part of the camera flange.
module cam_box() {
  box1_h = 13.7;
  box2_h = 0.8;
  box_h = box1_h + box2_h;
  standoff_h = 3;
  standoff_wall = 1.3;

  // Bottom part
  difference() {
    linear_extrude(height = box1_h)
      cam_box_2d();

    // Knockout for battery
    translate([battery_pos.x, battery_pos.y, box1_h / 2])
      cylinder(h = box1_h + 0.1, r = battery_r + battery_r_tolerance, center = true);

    // Holes to attach the pb tray
    for (pos = nut_pb_cam_posns) {
      translate([pos.x, pos.y, 4])
        rotate([180, 90, 0])
          nut_hole(M2_nut);
    }
  }

  // Top part
  translate([0, 0, box1_h])
    difference() {
      linear_extrude(height = box2_h)
        cam_box_2d();

      // Knockout for battery
      translate([battery_pos.x, battery_pos.y, box2_h / 2])
        cylinder(h = box2_h + 0.1, r1 = battery_r + battery_r_tolerance, r2 = battery_r - 0.8,
        center = true);
    }

  // Standoffs
  translate([cam_center_point.x, cam_center_point.y, box_h])
    standoffs(cam_holes, standoff_h, standoff_wall, cam_hole_r);
}

// Bracket for the camera flange
module cam_bracket() {
  // Ring attaches to flange and has slots for the trays
  linear_extrude(height = bracket_ring_h)
    cam_bracket_ring_2d();

  // Camera box sits _underneath_ the ring
  translate([0, 0, bracket_ring_h])
    cam_box();
}
