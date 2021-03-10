include <ec_common.scad>

include <../vitamin/adafruit.scad>

// Power tray 2d pattern
module pb_tray_2d() {
  difference() {
    union() {
      square([pb_tray_size.x, pb_tray_size.y], center = true);

      // pen_bracket tab
      translate([(pb_tray_size.x + pb_pen_tab.x) / 2, 0])
        square(pb_pen_tab, center = true);

      // Hack: extend the pb_tray into the attachment points on top of the pen_bracket
      // I can't extend the entire tab because it gets in the way of the USB cable
      for (y_pos = [(pb_pen_tab_width - attach.y) / 2, (- pb_pen_tab_width + attach.y) / 2]) {
        translate([pb_tray_size.x / 2 +  + pb_pen_tab.x + attach.z / 2, y_pos])
          square([attach.y, attach.z], center = true);
      }

      // cam_bracket tab is longer to reach the attachment points
      translate([- (pb_tray_size.x + pb_cam_tab.x) / 2, 0])
        square(pb_cam_tab, center = true);
    }

    // pen_bracket attachment holes
    for (hole = attach_pen_holes) {
      translate(hole)
        circle(r = attach_hole_r);
    }

    // cam_bracket attachment holes
    for (hole = attach_cam_holes) {
      translate(hole)
        circle(r = attach_hole_r);
    }

    // pb header knockout, rotate 90d
    // Make the hole bigger to expose the pin descriptions on the back of the board
    extra = 5;
    translate([pb_header_pos.x + pb_mount.x, pb_header_pos.y - pb_mount.y - extra / 2])
      square([pb_header_size.y, pb_header_size.x + extra], center = true);
  }
}

// Power tray
module pb_tray() {
  linear_extrude(height = pb_tray_size.z)
    pb_tray_2d();

  // Nibs to hold the power boost
  for (pb_hole = pb_holes) {
    translate([pb_hole.x + pb_mount.x, pb_hole.y + pb_mount.y, pb_tray_size.z])
      cylinder(h = pb_nib_h, r = pb_hole_r - 0.05);
  }
}
