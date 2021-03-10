include <ec_common.scad>

// Pi tray 2d pattern
module pi_tray_2d() {
  difference() {
    union() {
      square([pi_tray_size.x, pi_tray_size.y], center = true);

      // Tabs fit into bracket slots
      translate([(pi_tray_size.x + pi_pen_tab.x) / 2, 0])
        square(pi_pen_tab, center = true);
      translate([- (pi_tray_size.x + pi_cam_tab.x) / 2, 0])
        square(pi_cam_tab, center = true);
    }

    // pi header knockout
    translate([pi_header_pos.x + pi_mount.x, - pi_header_pos.y - pi_mount.y])
      square([pi_header_size.x, pi_header_size.y], center = true);
  }
}

// Pi tray
module pi_tray() {
  linear_extrude(height = pi_tray_size.z)
    pi_tray_2d();

  // Nibs to hold the pi zero
  for (pi_hole = pi_holes) {
    translate([pi_hole.x + pi_mount.x, pi_hole.y + pi_mount.y, pi_tray_size.z])
      cylinder(h = pi_nib_h, r = pi_hole_r - 0.05);
  }
}
