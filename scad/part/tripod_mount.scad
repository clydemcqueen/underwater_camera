// Tripod mount, leave room for a 1/4"-20 T-Nut
// You may need to adjust tnut_hole for your T-Nut

include <sc_common.scad>

tripod_mount_size = [joiner_size.x, stereo_mount_wide_width, 12.3];

module tnut_hole() {
  // Base
  base_h = 1.3;
  cylinder(d = 20, h = base_h);

  // Column
  cylinder(d1 = 10.5, d2 = 7.8, h = 13);

  // 4 spikes
  for (yaw = [0, 90, 180, 270]) {
    rotate([0, 0, yaw])
      translate([5.9, - 2.5, 0])
        cube([4, 1.6, 7.5 + base_h], center = false);
  }
}

module tripod_mount() {
  mount_h = 12.3;
  difference() {
    translate([- tripod_mount_size.x / 2, - tripod_mount_size.y / 2, 0])
      cube(tripod_mount_size, center = false);

    translate([0, 0, mount_h + 0.05])
      rotate([180, 0, 0])
        tnut_hole();

    // Holes for M3 screws
    for (hole = tripod_mount_holes) {
      translate([hole.x, hole.y, -0.05])
        cylinder(r = M3_screw_r, h = mount_h + 0.1);
    }

    // Inset the screws. Tricky printing, so use M3 washers
    for (hole = tripod_mount_holes) {
      translate([hole.x, hole.y, -0.05])
        cylinder(r = 3.5 + 0.05, h = tripod_screw_inset);
    }
  }
}

// Preview:
//$fn = 60;
//tnut_hole();
