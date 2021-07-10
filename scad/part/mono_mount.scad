include <mc_common.scad>

M3_sq_nut_width = 5.5;

// Create a recessed hole for a screw
// Screw hole and recess meet at [0, 0, 0] and run along the z axis
// Future: move to library
module recessed_screw_hole(length = 20) {
  linear_extrude(length)
    circle(M3_head_r);

  translate([0, 0, - length])
    linear_extrude(length + 0.1)
      circle(M3_screw_r);
}

module half() {
  half_nut_pos_y = mono_mount_half_size_y / 2 - 10;

  difference() {
    rotate([90, 0, 0])
      linear_extrude(mono_mount_half_size_y, center = true, convexity = 6)
        base_2d();

    // Slots for clamps
    for (slot_x = [- ridge_offset, ridge_offset]) {
      translate([slot_x, mono_mount_half_size_y / 2 - ridge_height / 2, 0])
        cube([ridge_width, ridge_height + 0.1, base_size.y + 0.1], center = true);
    }

    // Nuts to hold clamp screws
    // Use square M3 screws (hex screws can rotate)
    // Support square screws on 3 sides
    knockout_h = 20;
    stop_z = 10 + knockout_h / 2 - M3_sq_nut_width / 2;
    for (z = [- stop_z, stop_z]) {
      translate([0, half_nut_pos_y, z])
        cube([2 * M3_nut_flat_r, M3_nut_depth, knockout_h], center = true);
    }

    // Screw hole to mount to sub frame
    translate([3, 0, 0])
      rotate([0, 90, 0])
        recessed_screw_hole();
  }
}

module mono_mount() {
  half_pos_y = mono_mount_half_size_y / 2;

  translate([0, half_pos_y, 0])
    half();

  translate([0, - half_pos_y, 0])
    rotate([180, 0, 0])
      half();
}