// Stereo camera: show just the bracket and 2 tubes

include <flags.scad>

include <../part/loop_bracket.scad>
include <../part/stereo_clamp.scad>
include <../part/stereo_mount.scad>
include <../part/tripod_mount.scad>
include <NopSCADlib/core.scad>

module stereo_camera_assembly() {
  tripod_mount_z = - joiner_size.y / 2 - tripod_mount_size.z - 0.1;
  loop_bracket_z = joiner_size.y / 2  + 0.1;

  if (render_parts) {
    color("#57819a", 0.4)
      translate([- clamp_pos_x, 0, 0])
        rotate([90, 0, 90])
          stereo_clamp();

    color("#57819a", 0.4)
      translate([clamp_pos_x, 0, 0])
        rotate([90, 0, - 90])
          stereo_clamp();

    color("#4ea54c", 0.5)
      rotate([0, 0, 90])
        stereo_mount();

    color("#874ca5", 1.0)
      translate([0, 0, tripod_mount_z])
        tripod_mount();

    color("#874ca5", 1.0)
      translate([0, 0, loop_bracket_z])
        loop_bracket();
  }

  if (render_tube)
    color("gray", 0.6)
      rotate([0, 90, 0])
        for (pos_y = [- baseline / 2, baseline / 2]) {
          translate([0, pos_y, - tube_h / 2])
            two_inch_tube();
        }

  if (render_screws)
    for (hole = tripod_mount_holes) {
      translate([hole.x, hole.y, tripod_mount_z + tripod_screw_inset])
        rotate([180, 0, 0])
          screw(M3_cap_screw, 20);
    }
}

$fn = 60;
stereo_camera_assembly();
