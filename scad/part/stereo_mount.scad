include <sc_common.scad>

module middle() {
  difference() {
    rotate([90, 0, 0])
      linear_extrude(stereo_mount_middle_size_y, center = true, convexity = 5)
        joiner_2d(draw_holes = false);

    // Tripod mount: screw holes
    for (hole = tripod_mount_holes) {
      translate([hole.y, hole.x, 0])
        cylinder(r = M3_screw_r, h = 50, center = true);
    }

    // Tripod mount: nut holes
    // Use square M3 screws (hex screws can rotate)
    // Double up so that I can mount the tripod on the bottom or the top
    screw_depth = joiner_size.y / 2 - 8;
    for (hole_z = [- screw_depth, screw_depth]) {
      for (hole = tripod_mount_holes) {
        translate([hole.y, hole.x, hole_z])
          cube([30, 2 * M3_nut_flat_r, M3_nut_depth], center = true);
      }
    }
  }
}

module endcap() {
  endcap_nut_pos_y = stereo_mount_endcap_size_y / 2 - 10;

  difference() {
    rotate([90, 0, 0])
      linear_extrude(stereo_mount_endcap_size_y, center = true, convexity = 6)
        joiner_2d();

    // Slots for clamps
    for (slot_x = [- ridge_offset, ridge_offset]) {
      translate([slot_x, stereo_mount_endcap_size_y / 2 - ridge_height / 2, 0])
        cube([ridge_width, ridge_height + 0.1, joiner_size.y + 0.1], center = true);
    }

    // Nuts to hold clamp screws
    // Use square M3 screws (hex screws can rotate)
    translate([0, endcap_nut_pos_y, 0])
      cube([2 * M3_nut_flat_r, M3_nut_depth, 50], center = true);
  }
}

module stereo_mount() {
  endcap_pos_y = stereo_mount_middle_size_y / 2 + stereo_mount_endcap_size_y / 2;

  middle();

  translate([0, endcap_pos_y, 0])
    endcap();

  translate([0, - endcap_pos_y, 0])
    rotate([0, 0, 180])
      endcap();
}