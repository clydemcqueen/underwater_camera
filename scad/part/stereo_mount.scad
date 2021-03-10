include <sc_common.scad>

// Divide into middle bit + 2 endcaps
endcap_size_y = 15;
middle_size_y = total_stereo_mount_length - 2 * endcap_size_y;

module endcap() {
  endcap_nut_pos_y = endcap_size_y / 2 - 10;

  difference() {
    rotate([90, 0, 0])
      linear_extrude(endcap_size_y, center = true, convexity = 6)
        joiner_2d();

    // Slots for clamps
    for (slot_x = [- ridge_offset, ridge_offset]) {
      translate([slot_x, endcap_size_y / 2 - ridge_height / 2, 0])
        cube([ridge_width, ridge_height + 0.1, joiner_size.y + 0.1], center = true);
    }

    // Nuts to hold clamp screws
    // TODO use square M3 screws (hex screws can rotate)
    translate([0, endcap_nut_pos_y, 0])
      cube([2 * mount_nut_flat_r, mount_nut_depth, 50], center = true);

    // TODO create mechanism to add attachments
    // TODO create tripod mount attachment, with 1/4"-20 T-nut
    render_tripod_nut = false;
    if (render_tripod_nut) {
      // TODO come up with real #'s for the 1/4"-20 nut
      tripod_screw_r = 3;
      tripod_nut_r = 5;
      tripod_nut_depth = 5;
      tripod_nut_pos_z = - 20;

      // 1/4"-20 nut to mount on a tripod
      translate([0, 0, - 20])
        #cylinder(r = tripod_nut_r, h = tripod_nut_depth, $fn = 6);

      // 1/4" hole to reach nut
      translate([0, 0, - 30])
        #cylinder(r = tripod_screw_r, h = 10);
    }
  }
}

module stereo_mount() {
  endcap_pos_y = middle_size_y / 2 + endcap_size_y / 2;

  rotate([90, 0, 0])
    linear_extrude(middle_size_y, center = true)
      joiner_2d(draw_holes = false);

  translate([0, endcap_pos_y, 0])
    endcap();

  translate([0, - endcap_pos_y, 0])
    rotate([0, 0, 180])
      endcap();
}