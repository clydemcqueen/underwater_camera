include <../part/rear_cam_mount.scad>

// Hi-def render
$fn = 60;

// Print flat
translate([0, 0, rcm_size.x / 2])
  rotate([0, - 90, 0])
    rear_cam_mount();